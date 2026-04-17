#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>

@interface SavageMenu : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@end

%ctor {
    // SỬ DỤNG THỜI GIAN CHUẨN ĐỂ KHÔNG BỊ TRÀN SỐ
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        __block UIWindow *topWindow = nil;
        
        // CÁCH 1: LẤY THEO WINDOW SCENE (CHUẨN IOS 13-18)
        if (@available(iOS 13.0, *)) {
            for (UIScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                    topWindow = ((UIWindowScene *)scene).windows.firstObject;
                    break;
                }
            }
        }
        
        // CÁCH 2: BYPASS COMPILER ĐỂ LẤY KEYWINDOW (DIỆT LỖI DEPRECATED)
        if (!topWindow) {
            // Sử dụng Key-Value Coding để đánh lừa compiler
            @try {
                topWindow = [[UIApplication sharedApplication] valueForKey:@"keyWindow"];
            } @catch (NSException *exception) {
                // Nếu đen đủi không lấy được nữa thì lấy window đầu tiên trong mảng
                topWindow = [[UIApplication sharedApplication] windows].firstObject;
            }
        }

        // KÍCH HOẠT MENU XANH DƯƠNG CHO ĐẠI CA
        if (topWindow) {
            SavageMenu *menu = [[SavageMenu alloc] initWithFrame:CGRectMake(40, 40, 280, 420)];
            [topWindow addSubview:menu];
        }
    });
}
