include $(TOPDIR)/rules.mk

PKG_NAME:=dns-watcher
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT

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

define Build/Compile
	# Скриптовый пакет не требует компиляции исходного кода
	true
endef

define Package/dns-watcher/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/dns-watcher
	$(INSTALL_DIR) $(1)/usr/bin

	$(if $(wildcard ./files/etc/init.d/dns-watcher), \
		$(INSTALL_BIN) ./files/etc/init.d/dns-watcher $(1)/etc/init.d/dns-watcher)
	$(if $(wildcard ./files/usr/bin/dns-watcher), \
		$(INSTALL_BIN) ./files/usr/bin/dns-watcher $(1)/usr/bin/dns-watcher)
	$(if $(wildcard ./files/etc/dns-watcher/up.sh), \
		$(INSTALL_DATA) ./files/etc/dns-watcher/up.sh $(1)/etc/dns-watcher/)
	$(if $(wildcard ./files/etc/dns-watcher/down.sh), \
		$(INSTALL_DATA) ./files/etc/dns-watcher/down.sh $(1)/etc/dns-watcher/)
endef

$(eval $(call BuildPackage,dns-watcher))
