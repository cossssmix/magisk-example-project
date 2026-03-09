if ! $BOOTMODE; then
    ui_print "*********************************************************"
    ui_print "! Installation from recovery is NOT SUPPORTED"
    ui_print "! Use Magisk/KernelSU instead"
    abort "*********************************************************"
fi

if [ "$API" -lt 26 ]; then
    abort "! Android version lower than 8.0 is not supported"
fi

# Check Zygisk
check_zygisk() {
    if [ -d "/data/adb/modules/zygisksu" ] || [ -d "/data/adb/modules/rezygisk" ]; then
        return 0
    fi
    
    if [ -d "/data/adb/magisk" ]; then
        ZYGISK_STATUS=$(magisk --sqlite "SELECT value FROM settings WHERE key='zygisk';")
        if [ "$ZYGISK_STATUS" = "value=0" ]; then
            abort "! Enable Zygisk in Magisk settings or install ZygiskNext/ReZygisk"
        fi
    else
        abort "! Zygisk is required (enable in Magisk or install ZygiskNext)"
    fi
}

check_zygisk

ui_print "- Installation"
ui_print "- Done!"