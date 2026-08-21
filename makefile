# Цвета для вывода в консоль (ANSI escape codes)
CLR_RESET   := \033[0m
CLR_INFO    := \033[1;34m
CLR_SUCCESS := \033[1;32m
CLR_ERROR   := \033[1;31m

# 1. Сканируем проект и находим все Dockerfile
DOCKERFILES := $(wildcard */*/Dockerfile)

# 2. Собираем уникальный список технологий (первая папка: go, bun, dotnet...)
TECHNOLOGIES := $(sort $(foreach fd,$(DOCKERFILES),$(firstword $(subst /, ,$(fd)))))

# 3. Формируем точечные цели для конкретных версий (теперь строго с обычным дефисом -)
SPECIFIC_TARGETS := $(patsubst %/Dockerfile,%,$(DOCKERFILES))
SPECIFIC_TARGETS := $(subst /,-,$(SPECIFIC_TARGETS))

# Главная цель по умолчанию (если просто ввести make)
.DEFAULT_GOAL := help

# Показать список всех доступных команд
.PHONY: help
help:
	@echo -e "$(CLR_INFO)Доступные команды для сборки:$(CLR_RESET)"
	@echo -e "  $(CLR_SUCCESS)make build-all -j$(CLR_RESET)       - Собрать вообще ВСЕ образы асинхронно"
	@echo -e "\n$(CLR_INFO)Сборка конкретного языка целиком (все версии):$(CLR_RESET)"
	@for tech in $(TECHNOLOGIES); do echo -e "  $(CLR_SUCCESS)make $$tech -j$(CLR_RESET)"; done
	@echo -e "\n$(CLR_INFO)Сборка конкретной версии:$(CLR_RESET)"
	@for target in $(SPECIFIC_TARGETS); do echo -e "  $(CLR_SUCCESS)make $$target$(CLR_RESET)"; done

# Вариант 1: Собрать вообще ВСЕ технологии и ВСЕ версии
.PHONY: build-all
build-all: $(SPECIFIC_TARGETS)
	@echo -e "\n$(CLR_SUCCESS)🎉 ВСЕ СБОРКИ УСПЕШНО ЗАВЕРШЕНЫ! 🎉$(CLR_RESET)"

# Вариант 2: Сборка ЦЕЛОЙ технологии (например: make go -j)
.PHONY: $(TECHNOLOGIES)
$(TECHNOLOGIES):
	@$(MAKE) $(filter $@-%,$(SPECIFIC_TARGETS))

# Вариант 3: Сборка одной КОНКРЕТНОЙ версии (например: make go-1.25)
.PHONY: $(SPECIFIC_TARGETS)
$(SPECIFIC_TARGETS):
	$(eval PATH_DIR := $(subst -,/,$@))
	$(eval TECH := $(firstword $(subst -, ,$@)))
	$(eval VERSION := $(lastword $(subst -, ,$@)))
	$(eval IMAGE_NAME := $(TECH):$(VERSION))

	@echo -e "$(CLR_INFO)[⚙️  СТАРТ]$(CLR_RESET) Собираем образ $(CLR_INFO)$(IMAGE_NAME)$(CLR_RESET)..."

	@if docker build -t $(IMAGE_NAME) -f $(PATH_DIR)/Dockerfile ./$(TECH) > /dev/null 2>&1; then \
		echo -e "$(CLR_SUCCESS)[✅ УСПЕХ]$(CLR_RESET) Образ $(CLR_SUCCESS)$(IMAGE_NAME)$(CLR_RESET) успешно собран!"; \
	else \
		echo -e "$(CLR_ERROR)[❌ ОШИБКА]$(CLR_RESET) Не удалось собрать $(CLR_ERROR)$(IMAGE_NAME)$(CLR_RESET)! Выводим лог ошибки ниже:"; \
		echo -e "$(CLR_ERROR)----------------------------------------$(CLR_RESET)"; \
		docker build -t $(IMAGE_NAME) -f $(PATH_DIR)/Dockerfile ./$(TECH); \
		echo -e "$(CLR_ERROR)----------------------------------------$(CLR_RESET)"; \
		exit 1; \
	fi
