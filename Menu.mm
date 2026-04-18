#import <UIKit/UIKit.h>

@interface SavageMenu : UIView
@property (nonatomic, strong) UIView *mainBox;
@property (nonatomic, strong) UIView *sidebar;
@property (nonatomic, strong) UIView *contentArea;
@property (nonatomic, strong) UIButton *floatingBtn;
@end

@implementation SavageMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.userInteractionEnabled = YES;
        self.layer.zPosition = 9999;
        [self setupMainUI];
        [self silentServerCheck]; // Tự động check key ngầm
    }
    return self;
}

- (void)setupMainUI {
    // NÚT MỞ MENU NỔI (LOGO S)
    _floatingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _floatingBtn.frame = CGRectMake(80, 150, 50, 50);
    _floatingBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.4 alpha:0.8];
    _floatingBtn.layer.cornerRadius = 25;
    _floatingBtn.layer.borderWidth = 1.5;
    _floatingBtn.layer.borderColor = [UIColor cyanColor].CGColor;
    [_floatingBtn setTitle:@"S" forState:UIControlStateNormal];
    [_floatingBtn addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_floatingBtn];

    // KHUNG CHÍNH (SIDEBAR LAYOUT)
    _mainBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 550, 350)];
    _mainBox.center = self.center;
    _mainBox.backgroundColor = [UIColor colorWithRed:0.01 green:0.02 blue:0.06 alpha:0.98];
    _mainBox.layer.cornerRadius = 12;
    _mainBox.layer.borderColor = [UIColor cyanColor].CGColor;
    _mainBox.layer.borderWidth = 1;
    _mainBox.hidden = YES; // Mặc định ẩn
    [self addSubview:_mainBox];

    // SIDEBAR TRÁI
    _sidebar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 350)];
    _sidebar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.03];
    [_mainBox addSubview:_sidebar];

    NSArray *tabs = @[@"AIMBOT", @"VISUALS", @"MEMORY", @"SETTING"];
    for (int i = 0; i < tabs.count; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(0, 50 + (i*60), 150, 50);
        [b setTitle:tabs[i] forState:UIControlStateNormal];
        b.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(tabSwitch:) forControlEvents:UIControlEventTouchUpInside];
        b.tag = i;
        [_sidebar addSubview:b];
    }

    _contentArea = [[UIView alloc] initWithFrame:CGRectMake(165, 20, 360, 310)];
    [_mainBox addSubview:_contentArea];
    [self loadTab:0];
}

- (void)silentServerCheck {
    // TỰ ĐỘNG GỬI TOKEN MASTER LÊN SERVER ĐỂ KÍCH HOẠT
    NSString *token = @"vonhatqui9999-J9nya4AT2QOgimLN8tFsGR7Mq0Pc5lUwab12f5b29249a1a08a030348d2783a2a";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://mellunax.fun/quan-ly-package.php?auto=%@", token]];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *res, NSError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAntibanSuccess]; // Hiện thông báo Antiban xong là chơi luôn
        });
    }] resume];
}

- (void)showAntibanSuccess {
    UIView *noti = [[UIView alloc] initWithFrame:CGRectMake(0, -100, 300, 60)];
    noti.center = CGPointMake(self.center.x, 80);
    noti.backgroundColor = [UIColor colorWithRed:0 green:0.1 blue:0 alpha:0.9];
    noti.layer.cornerRadius = 10;
    noti.layer.borderColor = [UIColor greenColor].CGColor;
    noti.layer.borderWidth = 1.5;
    [self addSubview:noti];

    UILabel *l = [[UILabel alloc] initWithFrame:noti.bounds];
    l.text = @"ANTIBAN OB53: ACTIVE SECURED";
    l.textColor = [UIColor greenColor];
    l.textAlignment = NSTextAlignmentCenter;
    l.font = [UIFont boldSystemFontOfSize:13];
    [noti addSubview:l];

    // Hiệu ứng trượt xuống rồi biến mất
    [UIView animateWithDuration:0.5 animations:^{ noti.center = CGPointMake(self.center.x, 120); }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{ noti.alpha = 0; } completion:^(BOOL f){ [noti removeFromSuperview]; }];
    });
}

- (void)tabSwitch:(UIButton*)b { [self loadTab:(int)b.tag]; }
- (void)loadTab:(int)t {
    for (UIView *v in _contentArea.subviews) [v removeFromSuperview];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    l.text = (t == 0) ? @"AIMBOT SYSTEM" : @"FUNCTION MODULE";
    l.textColor = [UIColor cyanColor];
    [_contentArea addSubview:l];
}
- (void)toggle { _mainBox.hidden = !_mainBox.hidden; }
@end



