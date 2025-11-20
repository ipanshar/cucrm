@echo off
REM Скрипт для быстрой настройки CU CRM на Windows

echo ========================================
echo     CU CRM - Скрипт установки
echo ========================================
echo.

REM Проверка наличия конфигурационных файлов
if exist "data\config.php" (
    echo [OK] Файл data\config.php уже существует
) else (
    echo [*] Создаю data\config.php из шаблона...
    copy "data\config.php.example" "data\config.php"
    echo [!] ВАЖНО: Отредактируйте data\config.php (siteUrl)
)

echo.

if exist "data\config-internal.php" (
    echo [OK] Файл data\config-internal.php уже существует
) else (
    echo [*] Создаю data\config-internal.php из шаблона...
    copy "data\config-internal.php.example" "data\config-internal.php"
    echo [!] ВАЖНО: Отредактируйте data\config-internal.php (database, cryptKey, hashSecretKey)
)

echo.
echo ========================================
echo Создание необходимых директорий...
echo ========================================

if not exist "data\cache" mkdir "data\cache"
if not exist "data\logs" mkdir "data\logs"
if not exist "data\tmp" mkdir "data\tmp"
if not exist "data\upload" mkdir "data\upload"

echo [OK] Директории созданы

echo.
echo ========================================
echo Установка зависимостей через Composer...
echo ========================================
echo.

where composer >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    composer install
    echo [OK] Зависимости установлены
) else (
    echo [!] Composer не найден. Установите зависимости вручную: composer install
)

echo.
echo ========================================
echo Следующие шаги:
echo ========================================
echo.
echo 1. Создайте базу данных MySQL
echo 2. Отредактируйте data\config-internal.php
echo    - Настройте подключение к БД
echo    - Сгенерируйте случайные ключи
echo 3. Отредактируйте data\config.php
echo    - Установите правильный siteUrl
echo 4. Импортируйте дамп БД (если есть)
echo 5. Запустите: php clear_cache.php
echo 6. Запустите: php rebuild.php
echo.
echo ========================================

pause
