#import "Onboarding2ViewController.h"

@interface Onboarding2ViewController ()

@end

@implementation Onboarding2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRGBHexString:color_blue5 alpha:1.0f]];

    //Constraint for iPhoneSE
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 568)
        {
            self.topConstraint.constant = 8.0f;
        }
    }
    
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setText:NSLocalizedString(@"what_is_ooniprobe", nil)];
    
    NSMutableAttributedString *what_is_ooniprobe_1 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"what_is_ooniprobe_1", nil)];
    [what_is_ooniprobe_1 addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"FiraSans-SemiBold" size:17]
                    range:NSMakeRange(0, what_is_ooniprobe_1.length)];
    
    NSMutableAttributedString *what_is_ooniprobe_2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n%@", NSLocalizedString(@"what_is_ooniprobe_2", nil)]];
    [what_is_ooniprobe_2 addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"FiraSans-Regular" size:17]
                    range:NSMakeRange(0, what_is_ooniprobe_2.length)];

    NSMutableAttributedString *attr_str = [[NSMutableAttributedString alloc] init];
    [attr_str appendAttributedString:what_is_ooniprobe_1];
    [attr_str appendAttributedString:what_is_ooniprobe_2];
    [self.textLabel setAttributedText:attr_str];
    [self.textLabel setTextColor:[UIColor whiteColor]];
}

@end
