include $(TOPDIR)/rules.mk

PKG_NAME:=dns-watcher
PKG_VERSION:=1.0
PKG_RELEASE:=1

# Каноничное получение исходников через Git-репозиторий
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/postmdk/dns-watcher.git
PKG_SOURCE_VERSION:=main
PKG_MIRROR_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/dns-watcher
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Event-driven DNS monitoring service for OpenWrt
  DEPENDS:=+ubus +jsonfilter
  PKGARCH:=all
endef

define Package/dns-watcher/description
  Modular DNS tunnel watcher for OpenWrt using procd and external hooks.
endef

define Build/Configure
	# Скриптовый пакет не требует конфигурации
endef

define Build/Compile
	# Скриптовый пакет не требует компиляции
endef

define Package/dns-watcher/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/dns-watcher
	$(INSTALL_DIR) $(1)/usr/bin

	$(if $(wildcard $(PKG_BUILD_DIR)/files/etc/init.d/dns-watcher), \
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/etc/init.d/dns-watcher $(1)/etc/init.d/dns-watcher)
	$(if $(wildcard $(PKG_BUILD_DIR)/usr/bin/dns-watcher), \
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/dns-watcher $(1)/usr/bin/dns-watcher)
	$(if $(wildcard $(PKG_BUILD_DIR)/files/etc/dns-watcher/up.sh), \
		$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/etc/dns-watcher/up.sh $(1)/etc/dns-watcher/)
	$(if $(wildcard $(PKG_BUILD_DIR)/files/etc/dns-watcher/down.sh), \
		$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/dns-watcher/down.sh $(1)/etc/dns-watcher/)
endef

$(eval $(call BuildPackage,dns-watcher))
