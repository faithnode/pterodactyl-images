# Цвета для вывода в консоль (ANSI escape codes)
CLR_RESET   := \033[0m
CLR_INFO    := \033[1;34m
CLR_SUCCESS := \033[1;32m
CLR_ERROR   := \033[1;31m

# 1. Автоматически находим все Dockerfile в подпакках
DOCKERFILES := $(wildcard */*/Dockerfile)

# 2. Превращаем пути файлов в удобные названия целей (например: bun–1.1)
BUILD_TARGETS := $(patsubst %/Dockerfile,%,$(DOCKERFILES))
BUILD_TARGETS := $(subst /,–,$(BUILD_TARGETS))

# Главная цель, которая запустит всё
.PHONY: build-all
build-all: $(BUILD_TARGETS)
	@echo -e "\n$(CLR_SUCCESS)🎉 ВСЕ СБОРКИ УСПЕШНО ЗАВЕРШЕНЫ! 🎉$(CLR_RESET)"

# Универсальное правило для тихой сборки с присвоением имени образу
.PHONY: $(BUILD_TARGETS)
$(BUILD_TARGETS):
	$(eval PATH_DIR := $(subst –,/,$@))
	$(eval TECH := $(firstword $(subst –, ,$@)))
	$(eval VERSION := $(lastword $(subst –, ,$@)))
	$(eval IMAGE_NAME := $(TECH):$(VERSION))

	@echo -e "$(CLR_INFO)[⚙️  СТАРТ]$(CLR_RESET) Собираем образ $(CLR_INFO)$(IMAGE_NAME)$(CLR_RESET)..."

	@# > /dev/null полностью глушит успешный лог Docker.
	@# Флаг -t задает имя образу в формате технология:версия
	@if docker build -t $(IMAGE_NAME) -f $(PATH_DIR)/Dockerfile ./$(TECH) > /dev/null 2>&1; then \
		echo -e "$(CLR_SUCCESS)[✅ УСПЕХ]$(CLR_RESET) Образ $(CLR_SUCCESS)$(IMAGE_NAME)$(CLR_RESET) успешно собран и сохранен!"; \
	else \
		echo -e "$(CLR_ERROR)[❌ ОШИБКА]$(CLR_RESET) Не удалось собрать $(CLR_ERROR)$(IMAGE_NAME)$(CLR_RESET)! Выводим лог ошибки ниже:"; \
		echo -e "$(CLR_ERROR)----------------------------------------$(CLR_RESET)"; \
		docker build -t $(IMAGE_NAME) -f $(PATH_DIR)/Dockerfile ./$(TECH); \
		echo -e "$(CLR_ERROR)----------------------------------------$(CLR_RESET)"; \
		exit 1; \
	fi
