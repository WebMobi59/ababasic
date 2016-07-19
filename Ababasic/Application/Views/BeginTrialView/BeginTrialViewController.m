
#import "BeginTrialViewController.h"
#import "SignupForTrialViewController.h"
#import "SetUp1ViewController.h"

@interface BeginTrialViewController ()
@property (weak, nonatomic) IBOutlet UIView *resultTitleView, *sessionNewView, *sessionRedoView, *resultTrialView, *resultSentView;
@property (weak, nonatomic) IBOutlet UIButton *trialNewButton, *trialRedoButton, *trialDone, *button1, *button2, *button3, *buttonNew1, *buttonNew2, *buttonNew3, *buttonRedo1, *buttonRedo2, *buttonRedo3;

@property (weak, nonatomic) IBOutlet UILabel *TitleLanguage;
@property (weak, nonatomic) IBOutlet UILabel *TitleFruit;
@property (weak, nonatomic) IBOutlet UILabel *TitlePromptLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitlePromptType;

@property (weak, nonatomic) IBOutlet UILabel *RsultPromptLavel;
@property (weak, nonatomic) IBOutlet UILabel *ResultPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *FavorWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *ResultLangWordLabel;
@property (strong, nonatomic) IBOutlet UIView *superview;
@property (weak, nonatomic) IBOutlet UIButton *image1;
@property (weak, nonatomic) IBOutlet UIButton *image2;
@property (weak, nonatomic) IBOutlet UIButton *image3;
@property (weak, nonatomic) IBOutlet UILabel *eachResultLabel;


@end

int trialcount, targetcount, correctCounts, answer;
static Boolean flag = false;
float myScore;

NSString *type, *level;

NSInteger imageOrders[3];

@implementation BeginTrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    targetcount = [CommonUtils getTrialsCount];
    answer = [CommonUtils getAnswer];
    trialcount = 0;
    correctCounts = 0;
    
    NSString *tmp = [CommonUtils getLevel];
    type = [tmp componentsSeparatedByString:@" ("][0];
    level = [tmp componentsSeparatedByString:@" ("][1];
    level = [level substringToIndex:level.length - 1];
    
    if ( type == nil ) type = @"My Custom Test";
    if ( level == nil ) level = @"B";
    if ( targetcount ==0 ) targetcount = 3;
    [_LanguageLabel setText:[CommonUtils getLanguage]];
    [_FavorWordLabel setText:[CommonUtils getFavoriteWord]];
    [_ResultLangWordLabel setText:[NSString stringWithFormat:@"%@: %@", [CommonUtils getLanguage], [CommonUtils getFavoriteWord]]];
    
    [commonUtils setRoundedRectBorderButton:_image1 withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_image2 withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_image3 withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
}

//- (IBAction)back:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChanged)                                              name:UIDeviceOrientationDidChangeNotification                                        object:nil];
}

- (void) deviceOrientationChanged
{
    [self adjustViewsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void) adjustViewsForOrientation:(UIInterfaceOrientation) orientation {
    
    CGRect windowRect = self.view.frame;
    CGFloat windowWidth = windowRect.size.width;
    CGFloat windowHeight = windowRect.size.height;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            _image1.frame = CGRectMake(windowWidth/2 - 150, windowHeight/2 - 50, 80, 80);
            _image2.frame = CGRectMake(windowWidth/2 - 40, windowHeight/2 - 50, 80, 80);
            _image3.frame = CGRectMake(windowWidth/2 + 70, windowHeight/2 - 50, 80, 80);

        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            _image1.frame = CGRectMake(windowWidth/2 - 260, windowHeight/2 - 100, 160, 160);
            _image2.frame = CGRectMake(windowWidth/2 - 80, windowHeight/2 - 100, 160, 160);
            _image3.frame = CGRectMake(windowWidth/2 + 100, windowHeight/2 - 100, 160, 160);
        }
            break;
        case UIInterfaceOrientationUnknown:break;
    }
}

- (void) changeImageOrder
{
    for ( int i = 0; i < 3; i ++) {
     
        NSInteger tmp = imageOrders[i];
        int val = i + ( random() % (3 - i));
        imageOrders[i] = imageOrders[val];
        imageOrders[val] = tmp;
        
    }
    
    switch (imageOrders[0]) {
        case 0:
            [_image1 setBackgroundImage:appController.image1 forState:(UIControlStateNormal)];
            break;
        case 1:
            [_image1 setBackgroundImage:appController.image2 forState:(UIControlStateNormal)];
            break;
        case 2:
            [_image1 setBackgroundImage:appController.image3 forState:(UIControlStateNormal)];
            break;
        default:
            break;
    }
    
    switch (imageOrders[1]) {
        case 0:
            [_image2 setBackgroundImage:appController.image1 forState:(UIControlStateNormal)];
            break;
        case 1:
            [_image2 setBackgroundImage:appController.image2 forState:(UIControlStateNormal)];
            break;
        case 2:
            [_image2 setBackgroundImage:appController.image3 forState:(UIControlStateNormal)];
            break;
        default:
            break;
    }
    
    switch (imageOrders[2]) {
        case 0:
            [_image3 setBackgroundImage:appController.image1 forState:(UIControlStateNormal)];
            break;
        case 1:
            [_image3 setBackgroundImage:appController.image2 forState:(UIControlStateNormal)];
            break;
        case 2:
            [_image3 setBackgroundImage:appController.image3 forState:(UIControlStateNormal)];
            break;
        default:
            break;
    }
}

-(void)initUI{
    [commonUtils setRoundedRectBorderButton:_trialNewButton withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_trialRedoButton withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_trialDone withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_buttonNew1 withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_buttonNew2 withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_buttonNew3 withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_buttonRedo1 withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_buttonRedo2 withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_buttonRedo3 withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectView:_sessionNewView withCornerRadius:30.0f];
    [commonUtils setRoundedRectView:_sessionRedoView withCornerRadius:30.0f];
    [commonUtils setRoundedRectView:_resultSentView withCornerRadius:30.0f];
    
    _resultTitleView.hidden=YES;
    _sessionNewView.hidden=YES;
    _resultTrialView.hidden=YES;
    _sessionRedoView.hidden=YES;
    _resultSentView.hidden=YES;
    _eachResultLabel.hidden = YES;

    for ( int i = 0; i < 3; i ++) imageOrders[i] = i;

    [self changeImageOrder];
}

- (void) showResult
{
    NSString *lbl = @"Prompt Level: (";
    lbl = [lbl stringByAppendingFormat:@"%@)", level];
    [_TitlePromptLabel setText:lbl];
    [_RsultPromptLavel setText:lbl];
    
    lbl = @"Prompt Type: ";
    lbl = [lbl stringByAppendingFormat:@"%@", type];
    [_TitlePromptType setText:lbl];
    
    myScore = correctCounts * 100 / targetcount;
    lbl = [[NSNumber numberWithFloat:myScore] stringValue];
    lbl = [NSString stringWithFormat:@"%@%%", lbl];
    
    [_ResultPercentageLabel setText:lbl];
}

- (IBAction)button1Clicked:(id)sender {
    if ( trialcount < targetcount ) {
        if (answer == imageOrders[0]) {
            correctCounts += 1;
        } else {
            _eachResultLabel.hidden = NO;
            
        }
        trialcount ++;
        if ( trialcount == targetcount ) {
            [self showResult];
            
            _resultTitleView.hidden=NO;
            _resultTrialView.hidden=NO;
            
            _image1.hidden = YES;
            _image2.hidden = YES;
            _image3.hidden = YES;
        } else {
            [self changeImageOrder];
        }
        
    }
}

- (IBAction)button2Clicked:(id)sender {
    if ( trialcount < targetcount ) {
        if ( answer == imageOrders[1] ) correctCounts += 1;
        trialcount ++;
        if ( trialcount == targetcount ) {
            [self showResult];
            
            _resultTitleView.hidden=NO;
            _resultTrialView.hidden=NO;
            
            _image1.hidden = YES;
            _image2.hidden = YES;
            _image3.hidden = YES;
        } else {
            [self changeImageOrder];
        }

    }
}
- (IBAction)button3Clicked:(id)sender {
    if ( trialcount < targetcount ) {
        if ( answer == imageOrders[2] ) correctCounts += 1;
        trialcount ++;
        if ( trialcount == targetcount ) {
            [self showResult];
            
            _resultTitleView.hidden=NO;
            _resultTrialView.hidden=NO;
            
            _image1.hidden = YES;
            _image2.hidden = YES;
            _image3.hidden = YES;
        } else {
            [self changeImageOrder];
        }

    }
}

- (void) sendTrialHistory :(void (^)(BOOL isSuccess))completion{
    NSDictionary *parameters = @{@"token"       :[[NSUserDefaults standardUserDefaults] stringForKey:@"UserToken"],
                                 @"name"        :[CommonUtils getFavoriteWord],
                                 @"number"      :[[NSNumber numberWithInteger:[CommonUtils getTrialsCount]] stringValue],
                                 @"result"      :[[NSNumber numberWithFloat:myScore] stringValue],
                                 @"level"       :level,
                                 @"language"    :[CommonUtils getLanguage],
                                 @"prompt_type" :type};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://52.26.92.41/api/v1/trials" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary *)responseObject;
        if ([[responseData valueForKey:@"status"] isEqualToString:@"success"]) {
            BOOL success = [[responseData valueForKey:@"status"] isEqualToString:@"success"];
            completion(success);
//            flag = true;
        } else {
            [commonUtils showVAlertSimple:@"Warning" body:(NSString *)[responseData valueForKey:@"data"] duration:1.2];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Notice : %@", @"Internet connection is failed. Try it again later");
    }];
}
- (IBAction)trialNewButtonClicked:(id)sender {
    if ([CommonUtils getGuestState] == true) {
        _sessionNewView.hidden=NO;
    } else {
        [self sendTrialHistory:^(BOOL isSuccess){
            _sessionNewView.hidden=NO;
        }];
            
    }
}

- (IBAction)trialRedoButtonClicked:(id)sender {
    _sessionRedoView.hidden = NO;
}

- (IBAction)trialNewGobackClicked:(id)sender {
    _sessionNewView.hidden=YES;
}

- (IBAction)trialRedoGobackClicked:(id)sender {
    _sessionRedoView.hidden=YES;
}

- (IBAction)signupButtonClicked:(id)sender {
    _sessionNewView.hidden=YES;
    _sessionRedoView.hidden=YES;
    SignupForTrialViewController *signupForTrialViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"SignupForTrialViewController"];
    [self.navigationController pushViewController:signupForTrialViewController animated:YES];
}

- (IBAction)trialNewClicked:(id)sender {
    SetUp1ViewController *setUp1ViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SetUp1ViewController"];
    [self.navigationController pushViewController:setUp1ViewController animated:YES];
}

-(IBAction)trialDone:(id)sender{
    
    if ([CommonUtils getGuestState] == true) {
        return;
    }
    
    //Email subject
    NSString *emailTitle = @"ABA Basic DTT results";
    
    //Email Content
    
    NSString *lbl = [[NSNumber numberWithFloat:myScore] stringValue];
    lbl = [NSString stringWithFormat:@"%@%%", lbl];
    
    NSString *messageBody = [NSString stringWithFormat:@"%@\nPrompt Type: %@\ntarget:%@", lbl, type, [CommonUtils getFavoriteWord]];
    
    //To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"enriquealonso5990@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    //Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    [self sendTrialHistory:^(BOOL isSuccess){
        if (isSuccess) {
//            _sessionRedoView.hidden=NO;
        }
    }];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch(result){
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            _resultSentView.hidden=NO;
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//- (IBAction)onBack:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (IBAction)okButtonClicked:(id)sender {
    _resultSentView.hidden=YES;
}

@end
