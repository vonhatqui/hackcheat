#import <UIKit/UIKit.h>

@interface SavageMenu : UIView
@property (nonatomic, strong) UIView *mainPanel;
@property (nonatomic, strong) UIButton *gearBtn;
@property (nonatomic, strong) UIView *contentArea;
@property (nonatomic, strong) UISlider *fovSlider;
@property (nonatomic, strong) UILabel *fovLabel;
@end

@implementation SavageMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        // 1. NÚT CÀI ĐẶT NHỎ (GEAR)
        _gearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gearBtn.frame = CGRectMake(40, 100, 50, 50);
        _gearBtn.backgroundColor = [[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
        _gearBtn.layer.cornerRadius = 25;
        _gearBtn.layer.borderWidth = 1.5;
        _gearBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_gearBtn setTitle:@"⚙️" forState:UIControlStateNormal];
        [_gearBtn addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_gearBtn];

        // 2. DASHBOARD CHÍNH
        _mainPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
        _mainPanel.center = self.center;
        _mainPanel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.95];
        _mainPanel.layer.cornerRadius = 20;
        _mainPanel.layer.borderWidth = 2.0;
        _mainPanel.layer.borderColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0].CGColor;
        _mainPanel.hidden = YES;
        [self addSubview:_mainPanel];

        // --- THANH TAB BAR (MAIN - VISUAL - CÀI ĐẶT) ---
        NSArray *tabs = @[@"Main", @"Visual", @"Cài Đặt"];
        for (int i = 0; i < tabs.count; i++) {
            UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
            tab.frame = CGRectMake(i * (320/3.0), 0, 320/3.0, 45);
            [tab setTitle:tabs[i] forState:UIControlStateNormal];
            tab.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [tab setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
            tab.tag = i;
            [tab addTarget:self action:@selector(switchTab:) forControlEvents:UIControlEventTouchUpInside];
            [_mainPanel addSubview:tab];
        }

        // VÙNG NỘI DUNG
        _contentArea = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 320, 335)];
        [_mainPanel addSubview:_contentArea];
        
        [self showTab:0]; // Mặc định hiện Tab Main
    }
    return self;
}

- (void)switchTab:(UIButton *)sender {
    [self showTab:(int)sender.tag];
}

- (void)showTab:(int)index {
    // Xóa nội dung cũ
    for (UIView *v in _contentArea.subviews) [v removeFromSuperview];

    if (index == 0) { // --- TAB MAIN ---
        [self addLabel:@"AUTO AIMBOT" y:20 area:_contentArea];
        [self addSwitch:101 y:20 area:_contentArea];
        
        [self addLabel:@"AIM FOV" y:70 area:_contentArea];
        _fovSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 100, 240, 30)];
        _fovSlider.minimumValue = 30; _fovSlider.maximumValue = 360; _fovSlider.value = 180;
        [_fovSlider addTarget:self action:@selector(fovChanged:) forControlEvents:UIControlEventValueChanged];
        [_contentArea addSubview:_fovSlider];
        
        _fovLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 100, 40, 30)];
        _fovLabel.text = @"180"; _fovLabel.textColor = [UIColor cyanColor];
        [_contentArea addSubview:_fovLabel];
        
        [self addLabel:@"AUTO LOCK HEAD" y:150 area:_contentArea];
        [self addSwitch:102 y:150 area:_contentArea];

    } else if (index == 1) { // --- TAB VISUAL ---
        [self addLabel:@"ESP LINE" y:20 area:_contentArea];
        [self addSwitch:201 y:20 area:_contentArea];
        
        [self addLabel:@"ESP BOX" y:70 area:_contentArea];
        [self addSwitch:202 y:70 area:_contentArea];
        
        [self addLabel:@"ESP SKELETON" y:120 area:_contentArea];
        [self addSwitch:203 y:120 area:_contentArea];

    } else if (index == 2) { // --- TAB CÀI ĐẶT ---
        [self addLabel:@"NAME IPHONE: Savage 15 Pro" y:20 area:_contentArea];
        [self addLabel:@"STATUS: Connected" y:60 area:_contentArea];
        [self addLabel:@"VERSION: 2.0.26 (Final)" y:100 area:_contentArea];
        
        UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resetBtn.frame = CGRectMake(60, 180, 200, 40);
        resetBtn.backgroundColor = [UIColor redColor];
        resetBtn.layer.cornerRadius = 10;
        [resetBtn setTitle:@"KHÔI PHỤC OFFSET" forState:UIControlStateNormal];
        [_contentArea addSubview:resetBtn];
    }
}

// CÁC HÀM TIỆN ÍCH
- (void)addLabel:(NSString *)txt y:(float)y area:(UIView *)a {
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 220, 30)];
    l.text = txt; l.textColor = [UIColor whiteColor];
    l.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [a addSubview:l];
}

- (void)addSwitch:(int)tag y:(float)y area:(UIView *)a {
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(250, y, 0, 0)];
    s.onTintColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0];
    s.tag = tag;
    [a addSubview:s];
}

- (void)fovChanged:(UISlider *)s {
    _fovLabel.text = [NSString stringWithFormat:@"%d", (int)s.value];
}

- (void)toggleMenu { _mainPanel.hidden = !_mainPanel.hidden; }

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) return nil;
    return hitView;
}
@end
