if ! $BOOTMODE; then
    ui_print "*********************************************************"
    ui_print "! Установка из recovery НЕ ПОДДЕРЖИВАЕТСЯ"
    ui_print "! Ставь через Magisk/KernelSU"
    abort "*********************************************************"
fi

if [ "$API" -lt 26 ]; then
    abort "! Андроид ниже 8.0"
fi

# Проверка Zygisk
check_zygisk() {
    if [ -d "/data/adb/modules/zygisksu" ] || [ -d "/data/adb/modules/rezygisk" ]; then
        return 0
    fi
    
    if [ -d "/data/adb/magisk" ]; then
        ZYGISK_STATUS=$(magisk --sqlite "SELECT value FROM settings WHERE key='zygisk';")
        if [ "$ZYGISK_STATUS" = "value=0" ]; then
            abort "! Включи Zygisk в настройках Magisk или поставь ZygiskNext/ReZygisk"
        fi
    else
        abort "! Нужен Zygisk (включи в Magisk или поставь ZygiskNext)"
    fi
}

check_zygisk

ui_print "- Установка"
ui_print "- Готово!"