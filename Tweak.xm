#import <UIKit/UIKit.h>
#import <substrate.h>
#import <mach-o/dyld.h>

// BIẾN ĐIỀU KHIỂN
static bool isFovOn = false;
static float fovVal = 150.0f;

// --- LỚP VẼ VÒNG FOV CHUYÊN NGHIỆP ---
@interface SavageGFX : UIView
@end
@implementation SavageGFX
- (void)drawRect:(CGRect)rect {
    if (isFovOn) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(ctx, 1.5);
        CGContextSetStrokeColorWithColor(ctx, [UIColor cyanColor].CGColor);
        // Vẽ vòng nét đứt nhìn cho "nguy hiểm"
        CGFloat lengths[] = {5, 5};
        CGContextSetLineDash(ctx, 0, lengths, 2);
        CGRect c = CGRectMake(self.center.x - fovVal, self.center.y - fovVal, fovVal*2, fovVal*2);
        CGContextAddEllipseInRect(ctx, c);
        CGContextStrokePath(ctx);
    }
}
@end

static SavageGFX *overlay;

// --- HỆ THỐNG ANTIBAN (MỚI) ---
// Hook để giấu file dylib khi game quét thư mục cài đặt
static BOOL (*old_fileExistsAtPath)(NSFileManager* self, SEL _cmd, NSString* path);
BOOL new_fileExistsAtPath(NSFileManager* self, SEL _cmd, NSString* path) {
    if ([path containsString:@"SavageBlue"] || [path containsString:@".dylib"]) {
        return NO; // Trả về "Không tìm thấy" để bypass bảo vệ
    }
    return old_fileExistsAtPath(self, _cmd, path);
}

%hook UISwitch
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    %orig;
    if (self.tag == 301) {
        isFovOn = on;
        [overlay setNeedsDisplay];
    }
}
%end

%hook UISlider
- (void)setValue:(float)value animated:(BOOL)animated {
    %orig;
    if (self.tag == 999) {
        fovVal = value;
        [overlay setNeedsDisplay];
    }
}
%end

// --- KHỞI TẠO VÀ QUÉT ĐỊA CHỈ (SCAN OFFSET) ---
%ctor {
    // Chặn game quét file dylib ngay khi khởi tạo
    MSHookMessageEx([NSFileManager class], @selector(fileExistsAtPath:), (IMP)new_fileExistsAtPath, (IMP*)&old_fileExistsAtPath);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        if (!win && @available(iOS 13.0, *)) {
            for (UIWindowScene* s in [UIApplication sharedApplication].connectedScenes) {
                if (s.activationState == UISceneActivationStateForegroundActive) {
                    win = s.windows.firstObject; break;
                }
            }
        }
        
        if (win) {
            // Nạp Menu Dashboard
            Class mClass = NSClassFromString(@"SavageMenu");
            if (mClass) {
                UIView *v = [[mClass alloc] initWithFrame:win.bounds];
                [win addSubview:v];
            }
            // Nạp Overlay FOV
            overlay = [[SavageGFX alloc] initWithFrame:win.bounds];
            overlay.backgroundColor = [UIColor clearColor];
            overlay.userInteractionEnabled = NO;
            [win addSubview:overlay];
        }
    });
}


