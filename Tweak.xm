#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>

// KHAI BÁO CLASS ĐỂ COMPILER BIẾT ĐƯỜNG MÀ LẦN
@interface SavageMenu : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@end

%ctor {
    // SỬ DỤNG ĐỊNH NGHĨA THỜI GIAN AN TOÀN - FIX LỖI OVERFLOW
    uint64_t delayInSeconds = 5;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));

    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        UIWindow *topWindow = nil;
        
        // CÁCH LẤY WINDOW HIỆN ĐẠI BẤT CHẤP IOS 18+
        if (@available(iOS 13.0, *)) {
            for (UIScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if ([scene isKindOfClass:[UIWindowScene class]] && scene.activationState == UISceneActivationStateForegroundActive) {
                    topWindow = ((UIWindowScene *)scene).windows.firstObject;
                    break;
                }
            }
        }
        
        // NẾU KHÔNG LẤY ĐƯỢC THEO SCENE THÌ DÙNG CÁCH DỰ PHÒNG (FIX LỖI DEPRECATED)
        if (!topWindow) {
            topWindow = [[UIApplication sharedApplication] keyWindow];
        }

        if (topWindow) {
            // TẠO MENU XANH DƯƠNG CHO ĐẠI CA
            SavageMenu *menu = [[SavageMenu alloc] initWithFrame:CGRectMake(40, 40, 280, 420)];
            [topWindow addSubview:menu];
        }
    });
}
