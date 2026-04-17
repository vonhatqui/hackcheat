# THIẾT LẬP BUILD TỐI ƯU CHO ĐẠI CA
ARCHS = arm64 arm64e
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk
TARGET = iphone:clang:latest:15.0
DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SavageBlue2026
SavageBlue2026_FILES = Tweak.xm Menu.mm OffsetScanner.mm
SavageBlue2026_FRAMEWORKS = UIKit QuartzCore CoreGraphics Metal MetalKit
SavageBlue2026_CFLAGS = -fobjc-arc -Oz -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
