WEBMIN_FW_TCP_INCOMING = 22 80 443 5432 12321 12322

COMMON_OVERLAYS += adminer tkl-webcp
COMMON_CONF += adminer-lighttpd adminer-pgsql tkl-webcp

include $(FAB_PATH)/common/mk/turnkey/lighttpd.mk
include $(FAB_PATH)/common/mk/turnkey/php-fpm.mk
include $(FAB_PATH)/common/mk/turnkey/pgsql.mk
include $(FAB_PATH)/common/mk/turnkey.mk
