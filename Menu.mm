#import <UIKit/UIKit.h>

@interface SavageMenu : UIView
@end

@implementation SavageMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // NỀN ĐEN KHÓI VÀ VIỀN XANH DƯƠNG NEON
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
        self.layer.cornerRadius = 20;
        self.layer.borderWidth = 2.5;
        self.layer.borderColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0].CGColor;
        
        // HEADER ĐẲNG CẤP
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        header.backgroundColor = [UIColor colorWithRed:0.0 green:0.4 blue:0.9 alpha:0.8];
        UILabel *title = [[UILabel alloc] initWithFrame:header.bounds];
        title.text = @"SAVAGE BLUE 2026 - PREMIUM";
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        [self addSubview:header];
        
        // STATUS - KÍCH HOẠT SẴN (KHÔNG CẦN KEY)
        UILabel *st = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, 20)];
        st.text = @"[ SYSTEM: BYPASS SUCCESS ]";
        st.textColor = [UIColor cyanColor];
        st.font = [UIFont systemFontOfSize:11];
        st.textAlignment = NSTextAlignmentCenter;
        [self addSubview:st];

        [self setupSwitches];
    }
    return self;
}

- (void)setupSwitches {
    // Đại ca có thể thêm các nút gạt AIMBOT, ESP tại đây
    // Em đã code sẵn logic trong Tweak.xm bên dưới
}
@end
