# 🎯 Визуальная схема развертывания

## Что происходит при клонировании репозитория

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Repository                         │
│                                                              │
│  ✅ Исходный код (/application, /client, /custom)           │
│  ✅ Шаблоны конфигурации (*.example)                        │
│  ✅ Скрипты установки (setup.bat, setup.sh)                 │
│  ✅ Документация (README.md, *.md)                          │
│  ✅ composer.json                                            │
│                                                              │
│  ❌ НЕТ config.php (пароли!)                                │
│  ❌ НЕТ vendor/ (зависимости)                               │
│  ❌ НЕТ data/upload/ (файлы пользователей)                  │
│  ❌ НЕТ data/cache/ (кэш)                                   │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ git clone
                           ▼
┌─────────────────────────────────────────────────────────────┐
│              Локальная машина разработчика                   │
│                                                              │
│  📁 cucrm/                                                   │
│    ├── 📄 setup.bat / setup.sh  ◄─── Запустить это!        │
│    ├── 📄 data/config.php.example                           │
│    └── 📄 data/config-internal.php.example                  │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ Запуск setup.bat/setup.sh
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                 Автоматическая настройка                     │
│                                                              │
│  1️⃣  Копирование шаблонов:                                  │
│      config.php.example → config.php ✅                     │
│      config-internal.php.example → config-internal.php ✅   │
│                                                              │
│  2️⃣  Создание директорий:                                   │
│      data/cache/ ✅                                         │
│      data/logs/ ✅                                          │
│      data/tmp/ ✅                                           │
│      data/upload/ ✅                                        │
│                                                              │
│  3️⃣  Установка зависимостей:                                │
│      composer install ✅                                    │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ Ручная настройка
                           ▼
┌─────────────────────────────────────────────────────────────┐
│               Что нужно сделать вручную                      │
│                                                              │
│  1️⃣  Создать БД:                                            │
│      CREATE DATABASE cucrm ...                              │
│                                                              │
│  2️⃣  Отредактировать config-internal.php:                   │
│      - database (host, name, user, password)                │
│      - cryptKey (сгенерировать!)                            │
│      - hashSecretKey (сгенерировать!)                       │
│                                                              │
│  3️⃣  Отредактировать config.php:                            │
│      - siteUrl (http://localhost или ваш домен)             │
│                                                              │
│  4️⃣  Очистить кэш:                                          │
│      php clear_cache.php                                    │
│      php rebuild.php                                        │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
                      ✅ ГОТОВО!
```

## 🔐 Безопасность конфигурации

```
┌────────────────────────────────┐
│    config.php.example          │  ◄─── В Git ✅
│  (без паролей, общие настройки)│
└────────────────────────────────┘
              │
              │ copy / cp
              ▼
┌────────────────────────────────┐
│      config.php                │  ◄─── НЕ в Git ❌
│  (с реальными паролями!)       │      (в .gitignore)
└────────────────────────────────┘
```

## 📦 Структура после развертывания

```
cucrm/
├── 📄 .gitignore                  ✅ В Git
├── 📄 README.md                   ✅ В Git
├── 📄 QUICK_START.md              ✅ В Git
├── 📄 setup.bat                   ✅ В Git
├── 📄 setup.sh                    ✅ В Git
├── 📄 composer.json               ✅ В Git
│
├── 📁 application/                ✅ В Git
├── 📁 client/                     ✅ В Git
├── 📁 custom/                     ✅ В Git
│
├── 📁 vendor/                     ❌ НЕ в Git (composer install)
│
└── 📁 data/
    ├── 📄 config.php.example      ✅ В Git (шаблон)
    ├── 📄 config.php              ❌ НЕ в Git (настроенный)
    ├── 📄 config-internal.php.example  ✅ В Git (шаблон)
    ├── 📄 config-internal.php     ❌ НЕ в Git (с паролями!)
    ├── 📁 cache/                  ❌ НЕ в Git
    ├── 📁 logs/                   ❌ НЕ в Git
    ├── 📁 tmp/                    ❌ НЕ в Git
    └── 📁 upload/                 ❌ НЕ в Git
```

## 🚀 Команды для начала работы

### Вариант 1: Автоматически (рекомендуется)

**Windows:**
```bash
git clone <repo-url>
cd cucrm
setup.bat
# Затем отредактируйте data/config*.php
```

**Linux/Mac:**
```bash
git clone <repo-url>
cd cucrm
chmod +x setup.sh
./setup.sh
# Затем отредактируйте data/config*.php
```

### Вариант 2: Вручную

```bash
git clone <repo-url>
cd cucrm
copy data\config.php.example data\config.php
copy data\config-internal.php.example data\config-internal.php
composer install
# Отредактируйте data/config*.php
php clear_cache.php
php rebuild.php
```

## 💡 Подсказки

### Генерация ключей безопасности
```bash
php -r "echo bin2hex(random_bytes(16)) . PHP_EOL;"
```
Запустите дважды для двух ключей!

### Проверка, что конфиг НЕ в Git
```bash
git status
# Не должно показывать: data/config.php и data/config-internal.php
```

### Если случайно добавили конфиг в Git
```bash
git rm --cached data/config.php
git rm --cached data/config-internal.php
git commit -m "Remove sensitive config"
```
