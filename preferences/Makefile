include $(THEOS)/makefiles/common.mk

SDK_VERSION=11.2
SYSROOT=$(THEOS)/sdks/iPhoneOS11.2.sdk
TARGET = iphone:clang:11.0:latest

BUNDLE_NAME = notifyheaders
notifyheaders_FILES = NotifyHeaders.m
notifyheaders_INSTALL_PATH = /Library/PreferenceBundles
notifyheaders_FRAMEWORKS = UIKit
notifyheaders_PRIVATE_FRAMEWORKS = Preferences
notifyheaders_LIBRARIES = colorpicker
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NotifyHeadersPrefs.plist$(ECHO_END)
