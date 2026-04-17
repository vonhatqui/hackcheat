#import <substrate.h>
#import <UIKit/UIKit.h> // PHẢI CÓ CÁI NÀY ĐỂ HIỂU UIView, UIWindow
#import <dispatch/dispatch.h> // PHẢI CÓ CÁI NÀY ĐỂ HIỂU dispatch_after

// KHAI BÁO TRƯỚC LỚP MENU ĐỂ COMPILER KHÔNG BÁO LỖI UNDECLARED
@interface SavageMenu : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@end

// LOGIC TỰ DÒ OFFSET CỦA ĐẠI CA
void init_hack() {
    // Phần này Đại ca giữ nguyên logic tìm signature nhé
}

%ctor {
    // FIX LỖI: Sử dụng dispatch chuẩn chỉ
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        init_hack();

        // FIX LỖI: Khai báo UIWindow và UIView chuẩn iOS
        UIWindow *keyWindow = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
                if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                    keyWindow = windowScene.windows.firstObject;
                    break;
                }
            }
        } else {
            keyWindow = [UIApplication sharedApplication].keyWindow;
        }

        // TẠO MENU XANH DƯƠNG CHO ĐẠI CA
        if (keyWindow) {
            SavageMenu *menu = [[SavageMenu alloc] initWithFrame:CGRectMake(50, 50, 280, 400)];
            [keyWindow addSubview:menu];
        }
    });
}
