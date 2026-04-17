ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.5
DEBUG = 0
FINALPACKAGE = 1
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SavageBlue2026
SavageBlue2026_FILES = Tweak.xm Menu.mm OffsetScanner.mm
SavageBlue2026_FRAMEWORKS = UIKit QuartzCore CoreGraphics Metal Security
SavageBlue2026_CFLAGS = -fobjc-arc -Wno-unused-variable -Wno-unused-function

include $(THEOS_MAKE_PATH)/tweak.mk
