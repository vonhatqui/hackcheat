ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1

# ÉP XCODE DÙNG SDK ĐÃ TẢI
SDKVERSION = 14.5
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SavageBlue2026

# THÊM FILE MENU.MM VÀO ĐỂ NÓ HIỂU SAVAGEMENU LÀ GÌ
SavageBlue2026_FILES = Tweak.xm Menu.mm OffsetScanner.mm
SavageBlue2026_FRAMEWORKS = UIKit QuartzCore CoreGraphics Metal
SavageBlue2026_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
