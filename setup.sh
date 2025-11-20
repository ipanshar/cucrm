#!/bin/bash
# Скрипт для быстрой настройки CU CRM на Linux/Mac

echo "========================================"
echo "     CU CRM - Скрипт установки"
echo "========================================"
echo ""

# Проверка наличия конфигурационных файлов
if [ -f "data/config.php" ]; then
    echo "[OK] Файл data/config.php уже существует"
else
    echo "[*] Создаю data/config.php из шаблона..."
    cp data/config.php.example data/config.php
    echo "[!] ВАЖНО: Отредактируйте data/config.php (siteUrl)"
fi

echo ""

if [ -f "data/config-internal.php" ]; then
    echo "[OK] Файл data/config-internal.php уже существует"
else
    echo "[*] Создаю data/config-internal.php из шаблона..."
    cp data/config-internal.php.example data/config-internal.php
    echo "[!] ВАЖНО: Отредактируйте data/config-internal.php (database, cryptKey, hashSecretKey)"
fi

echo ""
echo "========================================"
echo "Создание необходимых директорий..."
echo "========================================"

mkdir -p data/cache
mkdir -p data/logs
mkdir -p data/tmp
mkdir -p data/upload

echo "[OK] Директории созданы"

echo ""
echo "========================================"
echo "Установка прав доступа..."
echo "========================================"

chmod -R 755 data/
chmod -R 755 custom/
chmod -R 755 client/custom/ 2>/dev/null || true

echo "[OK] Права установлены"

echo ""
echo "========================================"
echo "Установка зависимостей через Composer..."
echo "========================================"
echo ""

if command -v composer &> /dev/null; then
    composer install
    echo "[OK] Зависимости установлены"
else
    echo "[!] Composer не найден. Установите зависимости вручную: composer install"
fi

echo ""
echo "========================================"
echo "Следующие шаги:"
echo "========================================"
echo ""
echo "1. Создайте базу данных MySQL:"
echo "   CREATE DATABASE your_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
echo ""
echo "2. Отредактируйте data/config-internal.php"
echo "   - Настройте подключение к БД"
echo "   - Сгенерируйте случайные ключи:"
echo "     php -r \"echo bin2hex(random_bytes(16)) . PHP_EOL;\""
echo ""
echo "3. Отредактируйте data/config.php"
echo "   - Установите правильный siteUrl"
echo ""
echo "4. Импортируйте дамп БД (если есть):"
echo "   mysql -u user -p database_name < dump.sql"
echo ""
echo "5. Запустите: php clear_cache.php"
echo "6. Запустите: php rebuild.php"
echo ""
echo "========================================"
