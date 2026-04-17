#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>

// --- BIẾN TOÀN CỤC (Lưu trạng thái hack) ---
static bool isAimOn = false;
static bool isEspOn = false;
static float fovVal = 180.0f;

// --- HOOK VÀO HỆ THỐNG ĐỂ ĐIỀU KHIỂN ---

// Đánh chặn nút gạt trên Dashboard
%hook UISwitch
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    %orig;
    if (self.tag == 101) {
        isAimOn = on;
        NSLog(@"[Savage] Aimbot Active: %d", on);
    }
    if (self.tag == 201) {
        isEspOn = on;
        NSLog(@"[Savage] ESP Active: %d", on);
    }
}
%end

// Đánh chặn thanh kéo FOV
%hook UISlider
- (void)setValue:(float)value animated:(BOOL)animated {
    %orig;
    if (self.tag == 999) {
        fovVal = value;
    }
}
%end

// --- CƠ CHẾ CƯỠNG CHẾ HIỆN MENU ---
void ShowSavageMenu() {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject;
                    break;
                }
            }
        }
        if (!window) window = [UIApplication sharedApplication].keyWindow;

        if (window) {
            Class menuClass = NSClassFromString(@"SavageMenu");
            // Chỉ thêm nếu chưa tồn tại (tránh lag)
            if (menuClass && ![window viewWithTag:9988]) {
                UIView *menu = [[menuClass alloc] initWithFrame:window.bounds];
                menu.tag = 9988;
                [window addSubview:menu];
                [window bringSubviewToFront:menu];
                NSLog(@"[Savage] Dashboard đã nạp thành công!");
            }
        }
    });
}

%ctor {
    // Chạy lệnh hiện Menu sau 10 giây (khi đã qua logo Garena)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ShowSavageMenu();
    });
    
    // Quét lại lần 2 sau 20 giây để chắc chắn hiện trong sảnh
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ShowSavageMenu();
    });
}

