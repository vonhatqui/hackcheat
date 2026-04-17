#import <UIKit/UIKit.h>

@interface SavageMenu : UIView
@property (nonatomic, strong) UIView *mainBox;
@property (nonatomic, strong) UIView *sidebar;
@property (nonatomic, strong) UIView *contentArea;
@property (nonatomic, strong) UIButton *btnS;
@end

@implementation SavageMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.userInteractionEnabled = YES;
        self.layer.zPosition = 99999;

        // NÚT MỞ MENU (LOGO S TỰ VẼ)
        _btnS = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnS.frame = CGRectMake(60, 120, 50, 50);
        _btnS.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.4 alpha:0.8];
        _btnS.layer.cornerRadius = 8;
        _btnS.layer.borderWidth = 1.5;
        _btnS.layer.borderColor = [UIColor cyanColor].CGColor;
        [_btnS setTitle:@"S" forState:UIControlStateNormal];
        [_btnS setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        _btnS.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [_btnS addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnS];

        // KHUNG MENU CHÍNH (GIỐNG ẢNH)
        _mainBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 540, 350)];
        _mainBox.center = self.center;
        _mainBox.backgroundColor = [UIColor colorWithRed:0.01 green:0.02 blue:0.05 alpha:0.98];
        _mainBox.layer.cornerRadius = 12;
        _mainBox.layer.borderWidth = 1;
        _mainBox.layer.borderColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:0.3].CGColor;
        _mainBox.hidden = YES;
        [self addSubview:_mainBox];

        // THANH BÊN (SIDEBAR)
        _sidebar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 350)];
        _sidebar.backgroundColor = [UIColor colorWithRed:0.0 green:0.01 blue:0.03 alpha:0.6];
        [_mainBox addSubview:_sidebar];

        NSArray *tabs = @[@"AIMBOT", @"VISUALS", @"ANTIBAN", @"SETTINGS"];
        for (int i = 0; i < tabs.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, i * 65 + 30, 150, 50);
            [btn setTitle:tabs[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(tabChanged:) forControlEvents:UIControlEventTouchUpInside];
            [_sidebar addSubview:btn];
        }

        _contentArea = [[UIView alloc] initWithFrame:CGRectMake(165, 15, 360, 320)];
        [_mainBox addSubview:_contentArea];
        [self loadAimbotUI];
    }
    return self;
}

- (void)loadAimbotUI {
    for (UIView *v in _contentArea.subviews) [v removeFromSuperview];
    
    UILabel *h = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
    h.text = @"AIMBOT | SYSTEM CONFIG";
    h.textColor = [UIColor cyanColor];
    h.font = [UIFont boldSystemFontOfSize:13];
    [_contentArea addSubview:h];

    float y = 45;
    [self addRow:@"Aimbot (Lock Head)" tag:101 y:&y];
    [self addRow:@"Draw FOV Circle" tag:301 y:&y];
    [self addRow:@"Ignore AI Players" tag:103 y:&y];
    [self addRow:@"Visible Check" tag:104 y:&y];
    
    UILabel *sl = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 200, 20)];
    sl.text = @"FOV RANGE SENSITIVITY"; sl.textColor = [UIColor whiteColor];
    sl.font = [UIFont systemFontOfSize:10];
    [_contentArea addSubview:sl]; y+=25;

    UISlider *s = [[UISlider alloc] initWithFrame:CGRectMake(0, y, 320, 30)];
    s.tag = 999; s.minimumValue = 20; s.maximumValue = 400; s.value = 150;
    s.minimumTrackTintColor = [UIColor cyanColor];
    [_contentArea addSubview:s];
}

- (void)addRow:(NSString*)name tag:(int)tag y:(float*)y {
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(40, *y, 240, 30)];
    l.text = [name uppercaseString]; l.textColor = [UIColor whiteColor];
    l.font = [UIFont systemFontOfSize:11];
    [_contentArea addSubview:l];
    
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(0, *y, 0, 0)];
    s.tag = tag; s.onTintColor = [UIColor cyanColor];
    s.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [_contentArea addSubview:s];
    *y += 40;
}

- (void)toggle { _mainBox.hidden = !_mainBox.hidden; }
- (void)tabChanged:(UIButton*)b { if(b.tag == 0) [self loadAimbotUI]; }
@end


