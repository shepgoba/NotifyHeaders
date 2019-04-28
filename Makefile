include ~/theos/makefiles/common.mk
ARCHS = arm64 armv7 armv7s

DEBUG = 0
TARGET = iphone:clang:11.0:latest
TWEAK_NAME = NotifyHeaders
NotifyHeaders_FILES = Tweak.xm
NotifyHeaders_FRAMEWORKS = UIKit
NotifyHeaders_LIBRARIES = colorpicker
include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += preferences

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/aggregate.mk
