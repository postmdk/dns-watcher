include $(TOPDIR)/rules.mk

PKG_NAME:=dns-watcher
PKG_RELEASE:=1

include $(INCLUDE_dir)/package.mk

define Package/dns-watcher
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Modular DNS tunnel watcher
  DEPENDS:=+ubus +jsonfilter
endef

define Package/dns-watcher/description
  Event-driven DNS monitoring service for OpenWrt tunnels using procd and external hooks.
endef

define Build/Compile
	# Если у вас чисто скриптовый демон (shell), компиляция не нужна
	true
endef

define Package/dns-watcher/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/dns-watcher
	$(INSTALL_DIR) $(1)/usr/bin
	
	$(INSTALL_BIN) ./files/etc/init.d/dns-watcher $(1)/etc/init.d/dns-watcher
	$(INSTALL_BIN) ./files/usr/bin/dns-watcher $(1)/usr/bin/dns-watcher
	$(if $(wildcard ./files/etc/dns-watcher/up.sh),$(INSTALL_DATA) ./files/etc/dns-watcher/up.sh $(1)/etc/dns-watcher/)
	$(if $(wildcard ./files/etc/dns-watcher/down.sh),$(INSTALL_DATA) ./files/etc/dns-watcher/down.sh $(1)/etc/dns-watcher/)
endef

$(eval $(call BuildPackage,dns-watcher))
