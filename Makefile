WEBMIN_FW_TCP_INCOMING = 22 80 443 5432 12320 12321

COMMON_CONF =

include $(FAB_PATH)/common/mk/turnkey/pgsql.mk
include $(FAB_PATH)/common/mk/turnkey.mk
