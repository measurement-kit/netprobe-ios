#import "TestRunningViewController.h"

@interface TestRunningViewController ()

@end

@implementation TestRunningViewController
@synthesize currentTest;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[TestUtility getColorForTest:currentTest.result.test_group_name]];
    
    if (currentTest){
        totalTests = [currentTest.mkNetworkTests count];
        [currentTest runTestSuite];
    }
    
    self.progressBar.layer.cornerRadius = 7.5;
    self.progressBar.layer.masksToBounds = YES;
    [self.progressBar setTrackTintColor:[UIColor colorWithRGBHexString:color_white alpha:0.2f]];
    [self.runningTestsLabel setText:[NSString stringWithFormat:@"%@:", NSLocalizedString(@"Dashboard.Running.Running", nil)]];
    [self.logLabel setText:@""];
    [self.etaLabel setText:[NSString stringWithFormat:@"%@:", NSLocalizedString(@"Dashboard.Running.EstimatedTimeLeft", nil)]];

    //TODO-TIME Estimated Time test
    [self.timeLabel setText:[NSString stringWithFormat:@"0 seconds"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress:) name:@"updateProgress" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkTestEnded) name:@"networkTestEnded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLog:) name:@"updateLog" object:nil];

    if ([SettingsUtility getSettingWithName:@"keep_screen_on"]){
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addAnimation];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}


-(void)addAnimation{
    animation = [LOTAnimationView animationNamed:currentTest.result.test_group_name];
    //[animation setBackgroundColor:[TestUtility getColorForTest:currentTest.result.test_group_name]];
    //animation.frame = self.animationView.bounds;
    //animation.center = self.animationView.center;
    animation.contentMode = UIViewContentModeScaleAspectFit;
    
    //NSLog(@"SIZE1 %f %f", animation.frame.size.width, animation.frame.size.height);
    
    CGRect c = self.animationView.bounds;
    animation.frame = CGRectMake(0, 0, c.size.width, c.size.height);
    [self.animationView setNeedsLayout];
    [self.animationView setClipsToBounds:YES];
    [self.animationView addSubview:animation];

    //NSLog(@"SIZE2 %f %f", c.size.width, c.size.height);
    
    [animation setLoopAnimation:YES];
    [animation play];
}

-(void)updateLog:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *log = [userInfo objectForKey:@"log"];
    [self.logLabel setText:log];
}

-(void)updateProgress:(NSNotification *)notification{
    /*
     Format string with minute and seconds
     https://stackoverflow.com/questions/27519533/how-to-format-date-in-to-string-like-as-one-days-ago-minutes-ago-in-ios
     https://stackoverflow.com/questions/2927028/how-do-i-get-hour-and-minutes-from-nsdate
     */
    NSDictionary *userInfo = notification.userInfo;
    NSString *name = [userInfo objectForKey:@"name"];
    NSNumber *prog = [userInfo objectForKey:@"prog"];
    NSNumber *index = [userInfo objectForKey:@"index"];
    float prevProgress = [index floatValue]/totalTests;
    float progress = ([prog floatValue]/totalTests)+prevProgress;
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.currentTestLabel setText:[NSString stringWithFormat:@"... %@ %@", [NSLocalizedString(@"running", nil) lowercaseString], NSLocalizedString(name, nil)]];
        [self.progressBar setProgress:progress animated:YES];
        [self.testNameLabel setText:[LocalizationUtility getNameForTest:name]];

    });
    [animation playWithCompletion:^(BOOL animationFinished) {
        //[animation removeFromSuperview];
    }];

}

-(void)networkTestEnded{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_presenting){
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:TRUE completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goToResults" object:nil];
            }];
        }
        else {
            [self dismissViewControllerAnimated:TRUE completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goToResults" object:nil];
            }];
        }
    });

}

@end
