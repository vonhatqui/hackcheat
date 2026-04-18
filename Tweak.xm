#import <UIKit/UIKit.h>
#import <substrate.h>

// --- BIẾN ĐIỀU KHIỂN ---
static bool isAimbot = true;
static float fovSize = 150.0f;

// --- HOOK ANTIBAN NGẦM ---
%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
    // Luôn báo không thấy các file dylib để tránh bị quét
    if ([path containsString:@".dylib"] || [path containsString:@"Savage"]) return NO;
    return %orig;
}
%end

// Chặn gửi crash log về Garena
%hook FIRApp // Nếu game dùng Firebase
+ (void)configure { return; }
%end

%ctor {
    // Đợi 10 giây cho game load hết rồi hiện Menu
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        if (!win && @available(iOS 13.0, *)) {
            for (UIWindowScene* s in [UIApplication sharedApplication].connectedScenes) {
                if (s.activationState == UISceneActivationStateForegroundActive) {
                    win = s.windows.firstObject; break;
                }
            }
        }
        
        if (win) {
            Class menuClass = NSClassFromString(@"SavageMenu");
            if (menuClass) {
                UIView *v = [[menuClass alloc] initWithFrame:win.bounds];
                [win addSubview:v];
            }
        }
    });
}



