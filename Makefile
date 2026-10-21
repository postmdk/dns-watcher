include $(TOPDIR)/rules.mk

PKG_NAME:=dns-watcher
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Dmitry Morozov
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/dns-watcher
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Modular DNS tunnel watcher
  DEPENDS:=+ubus +jsonfilter
  PKGARCH:=all
endef

define Package/dns-watcher/description
  Event-driven DNS monitoring service for OpenWrt tunnels using procd and external hooks.
endef

define Build/Prepare

	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
	# Empty
endef

define Package/dns-watcher/install
	# Copy all struture from folder files/ in rootfs router
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,dns-watcher))
