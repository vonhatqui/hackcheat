#import <UIKit/UIKit.h>

@interface SavageMenu : UIView
@end

@implementation SavageMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
        self.layer.cornerRadius = 20;
        self.layer.borderWidth = 2.5;
        self.layer.borderColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0].CGColor;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        header.backgroundColor = [UIColor colorWithRed:0.0 green:0.4 blue:0.9 alpha:0.8];
        UILabel *title = [[UILabel alloc] initWithFrame:header.bounds];
        title.text = @"SAVAGE BLUE - NO KEY";
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:header];

        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, 20)];
        status.text = @"[ BYPASS ACTIVE ]";
        status.textColor = [UIColor cyanColor];
        status.textAlignment = NSTextAlignmentCenter;
        [self addSubview:status];
    }
    return self;
}
@end
