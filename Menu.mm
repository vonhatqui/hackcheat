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
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.layer.zPosition = 9999;

        // 1. NÚT GEAR NỔI (FLOATING)
        _gearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gearBtn.frame = CGRectMake(40, 150, 55, 55);
        _gearBtn.backgroundColor = [[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
        _gearBtn.layer.cornerRadius = 27.5;
        _gearBtn.layer.borderWidth = 2.0;
        _gearBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_gearBtn setTitle:@"⚙️" forState:UIControlStateNormal];
        _gearBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_gearBtn addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_gearBtn addGestureRecognizer:pan];
        [self addSubview:_gearBtn];

        // 2. DASHBOARD CHÍNH
        _mainPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
        _mainPanel.center = self.center;
        _mainPanel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.95];
        _mainPanel.layer.cornerRadius = 25;
        _mainPanel.layer.borderWidth = 2.5;
        _mainPanel.layer.borderColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0].CGColor;
        _mainPanel.hidden = YES;
        [self addSubview:_mainPanel];

        // TAB BAR
        NSArray *tabs = @[@"Main", @"Visual", @"Cài Đặt"];
        for (int i = 0; i < tabs.count; i++) {
            UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
            tab.frame = CGRectMake(i * (320/3.0), 0, 320/3.0, 50);
            [tab setTitle:tabs[i] forState:UIControlStateNormal];
            tab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            tab.tag = i;
            [tab addTarget:self action:@selector(switchTab:) forControlEvents:UIControlEventTouchUpInside];
            [_mainPanel addSubview:tab];
        }

        _contentArea = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 360)];
        [_mainPanel addSubview:_contentArea];
        [self loadTabData:0];
    }
    return self;
}

- (void)switchTab:(UIButton *)s { [self loadTabData:(int)s.tag]; }

- (void)loadTabData:(int)index {
    for (UIView *v in _contentArea.subviews) [v removeFromSuperview];
    if (index == 0) {
        [self addLabel:@"AUTO AIMBOT (REAL)" y:20];
        [self addSwitch:101 y:20];
        [self addLabel:@"AIM FOV" y:80];
        _fovSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 110, 240, 30)];
        _fovSlider.tag = 999;
        _fovSlider.minimumValue = 10; _fovSlider.maximumValue = 360; _fovSlider.value = 180;
        [_fovSlider addTarget:self action:@selector(fovCh:) forControlEvents:UIControlEventValueChanged];
        [_contentArea addSubview:_fovSlider];
        _fovLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 110, 40, 30)];
        _fovLabel.text = @"180"; _fovLabel.textColor = [UIColor cyanColor];
        [_contentArea addSubview:_fovLabel];
        [self addLabel:@"GHIM ĐẦU (LOCK)" y:170];
        [self addSwitch:102 y:170];
    } else if (index == 1) {
        [self addLabel:@"ESP LINE" y:20]; [self addSwitch:201 y:20];
        [self addLabel:@"ESP BOX" y:80]; [self addSwitch:202 y:80];
    } else {
        [self addLabel:@"DEVICE: Savage iPhone" y:20];
        [self addLabel:@"VERSION: OB52 - FINAL" y:60];
        [self addLabel:@"STATUS: BYPASS ACTIVE" y:100];
    }
}

- (void)addLabel:(NSString *)t y:(float)y {
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 220, 30)];
    l.text = t; l.textColor = [UIColor whiteColor];
    [_contentArea addSubview:l];
}

- (void)addSwitch:(int)tag y:(float)y {
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(250, y, 0, 0)];
    s.tag = tag;
    s.onTintColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0];
    [_contentArea addSubview:s];
}

- (void)fovCh:(UISlider *)s { _fovLabel.text = [NSString stringWithFormat:@"%d", (int)s.value]; }
- (void)toggleMenu { _mainPanel.hidden = !_mainPanel.hidden; }
- (void)handlePan:(UIPanGestureRecognizer *)p {
    CGPoint t = [p translationInView:self];
    _gearBtn.center = CGPointMake(_gearBtn.center.x + t.x, _gearBtn.center.y + t.y);
    [p setTranslation:CGPointZero inView:self];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *v = [super hitTest:point withEvent:event];
    return (v == self) ? nil : v;
}
@end

