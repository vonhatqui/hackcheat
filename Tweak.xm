#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>

// FIX LỖI UNDECLARED CHO COMPILER 2026
extern "C" dispatch_queue_t dispatch_get_main_queue(void);
extern "C" void dispatch_after(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block);
extern "C" dispatch_time_t dispatch_time(dispatch_time_t when, int64_t delta);

@interface SavageMenu : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@end

%ctor {
    // Chờ 5 giây sau khi game mở để nhúng Menu
    dispatch_after(dispatch_time(0, (int64_t)(5 * 1000000000)), dispatch_get_main_queue(), ^{
        
        UIWindow *topWindow = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    topWindow = scene.windows.firstObject;
                    break;
                }
            }
        }
        if (!topWindow) topWindow = [UIApplication sharedApplication].keyWindow;

        if (topWindow) {
            SavageMenu *menu = [[SavageMenu alloc] initWithFrame:CGRectMake(40, 40, 280, 420)];
            [topWindow addSubview:menu];
        }
    });
}
