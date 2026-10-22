include $(TOPDIR)/rules.mk

PKG_NAME:=dns-watcher
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

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

define Package/dns-watcher/conffiles
/etc/config/dns-watcher
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/dns-watcher/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/dns-watcher
	$(INSTALL_DIR) $(1)/usr/bin

	$(INSTALL_CONF) ./files/etc/config/dns-watcher $(1)/etc/config/dns-watcher
	$(INSTALL_BIN) ./files/etc/init.d/dns-watcher $(1)/etc/init.d/dns-watcher
	$(INSTALL_BIN) ./files/usr/bin/dns-watcher $(1)/usr/bin/dns-watcher
	$(INSTALL_BIN) ./files/etc/dns-watcher/up.sh $(1)/etc/dns-watcher/
	$(INSTALL_BIN) ./files/etc/dns-watcher/down.sh $(1)/etc/dns-watcher/
endef

$(eval $(call BuildPackage,dns-watcher))
