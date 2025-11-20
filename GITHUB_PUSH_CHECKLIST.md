# ✅ Чеклист перед первым push в GitHub

## Шаг 1: Проверка .gitignore

```powershell
# Проверьте, что .gitignore существует и работает
Get-Content .gitignore

# Проверьте статус Git
git status

# Убедитесь, что эти файлы НЕ отображаются:
# ❌ data/config.php
# ❌ data/config-internal.php
# ❌ data/cache/*
# ❌ data/logs/*
# ❌ data/upload/*
# ❌ vendor/*
```

## Шаг 2: Инициализация Git (если еще не сделано)

```powershell
# Инициализируйте Git
git init

# Добавьте все файлы
git add .

# Проверьте, что будет добавлено
git status
```

## Шаг 3: Проверка файлов для коммита

```powershell
# Список файлов, которые будут добавлены
git diff --cached --name-only

# ✅ ДОЛЖНЫ быть:
# - .gitignore
# - .gitattributes
# - data/config.php.example
# - data/config-internal.php.example
# - .env.example
# - README.md
# - QUICK_START.md
# - SECURITY_KEYS.md
# - DEPLOYMENT_GUIDE.md
# - DEPLOYMENT_CHECKLIST.md
# - setup.bat
# - setup.sh
# - application/**
# - client/**
# - custom/**
# - composer.json

# ❌ НЕ ДОЛЖНЫ быть:
# - data/config.php
# - data/config-internal.php
# - .env
# - data/cache/**
# - data/logs/**
# - vendor/**
```

## Шаг 4: Первый коммит

```powershell
git commit -m "Initial commit: CU CRM project with documentation and setup scripts"
```

## Шаг 5: Создание репозитория на GitHub

1. Перейдите на https://github.com/new
2. Создайте новый репозиторий (например: `cucrm`)
3. НЕ добавляйте README, .gitignore или лицензию (они уже есть)

## Шаг 6: Подключение к GitHub

```powershell
# Добавьте remote (замените YOUR_USERNAME и YOUR_REPO)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# Переименуйте ветку в main (если нужно)
git branch -M main

# Первый push
git push -u origin main
```

## Шаг 7: Проверка на GitHub

1. Откройте ваш репозиторий на GitHub
2. Проверьте, что:
   - ✅ Видны все файлы документации
   - ✅ Есть data/config.php.example
   - ✅ Есть data/config-internal.php.example
   - ❌ НЕТ data/config.php
   - ❌ НЕТ data/config-internal.php
   - ❌ НЕТ папки vendor/

## Шаг 8: Тестирование клонирования

```powershell
# В другой папке склонируйте репозиторий
cd D:\test
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# Запустите setup
.\setup.bat

# Проверьте, что все работает
```

## 🎉 Готово!

Теперь ваша команда может клонировать репозиторий и быстро развернуть проект!

## 📝 Полезные команды после

```powershell
# Просмотр игнорируемых файлов
git status --ignored

# Проверка конкретного файла
git check-ignore -v data/config.php

# Должно показать:
# .gitignore:4:/data/config.php    data/config.php
```

## ⚠️ Если что-то пошло не так

### Случайно добавили config.php?

```powershell
# Удалите из Git (файл останется локально)
git rm --cached data/config.php
git rm --cached data/config-internal.php
git commit -m "Remove sensitive files"
git push
```

### Забыли добавить .example файлы?

```powershell
# Принудительно добавьте их
git add -f data/config.php.example
git add -f data/config-internal.php.example
git commit -m "Add config templates"
git push
```

### Нужно изменить .gitignore?

```powershell
# Редактируйте .gitignore
# Затем удалите кэш Git
git rm -r --cached .
git add .
git commit -m "Update .gitignore"
git push
```
