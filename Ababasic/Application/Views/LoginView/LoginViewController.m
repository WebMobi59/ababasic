//
//  LoginViewController.m
//  Ababasic
//
//  Created by Superlight on 4/17/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "LoginViewController.h"
#import "SetUp1ViewController.h"
#import "UserProfileViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *roundView1;
@property (weak, nonatomic) IBOutlet UIImageView *roundView2;

@property (weak, nonatomic) IBOutlet UIButton *btn_login,*btn_signup,*btn_preceed;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFiled,*passTextField;
@property (weak, nonatomic) IBOutlet UILabel *MarkLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [commonUtils setRoundedRectBorderImage:_roundView1 withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
    [_roundView1 setBackgroundColor:[UIColor whiteColor]];
    [commonUtils setRoundedRectBorderImage:_roundView2 withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
    [_roundView2 setBackgroundColor:[UIColor whiteColor]];
    [commonUtils setRoundedRectBorderButton:_btn_login withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
    [commonUtils setRoundedRectBorderButton:_btn_signup withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
    [commonUtils setRoundedRectBorderButton:_btn_preceed withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
        // Do any additional setup after loading the view.
    _MarkLabel.layer.borderWidth = 2.0f;
    _MarkLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _MarkLabel.layer.cornerRadius = 5.0f;
    
    [self fadein];
    
}

-(void) fadein
{
    _MarkLabel.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2];
    _MarkLabel.alpha = 1;
    [UIView commitAnimations];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished    context:(void *)context {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    _MarkLabel.alpha = 0;
    [UIView commitAnimations];
}

- (IBAction)onClickLoginButton:(id)sender {

    if([commonUtils isFormEmpty:[@[self.emailTextFiled.text, self.passTextField.text] mutableCopy]]) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Please complete entire form" duration:1.2];
    } else if(![commonUtils validateEmail:self.emailTextFiled.text]) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Email address is not in a vaild format" duration:1.2];
    } else if([self.passTextField.text length] < 6 || [self.passTextField.text length] > 10) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Password length must be between 6 and 10 characters" duration:1.2];
    } else {
        
        NSDictionary *parameters = @{@"email":self.emailTextFiled.text,
                                     @"password":self.passTextField.text};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager POST:@"http://52.26.92.41/api/v1/accounts/sign_in" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *responseData = (NSDictionary *)responseObject;
            
            if ([[responseData valueForKey:@"status"] isEqualToString:@"success"]) {
                NSDictionary *result = (NSDictionary *)[responseData valueForKey:@"data"];
                [self parseResult:result];
                UserProfileViewController* userProfileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
                [self.navigationController pushViewController:userProfileVC animated:YES];
            } else {
                [commonUtils showVAlertSimple:@"Notice" body:(NSString *)[responseData valueForKey:@"data"] duration:1.2];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [commonUtils showVAlertSimple:@"Notice" body:@"Internet connection is failed. Try it again later" duration:1.2];
            
        }];
    }
}

- (void) parseResult:(NSDictionary *) results {
    
    NSString *token = (NSString *)[results valueForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"UserToken"];
    [userManage setUserId:(NSString *)[results valueForKey:@"id"]];
    [userManage setUserName:(NSString *)[results valueForKey:@"name"]];
    [userManage setUserEmailAddress:(NSString *)[results valueForKey:@"email"]];
    [userManage setUserBirthday:(NSString *)[results valueForKey:@"birthday"]];
    [userManage setUserSchool:(NSString *)[results valueForKey:@"school"]];
    [userManage setUserDiagnosis:(NSString *)[results valueForKey:@"diagnosis"]];
    
    NSString *userPhotoURL = (NSString *)[results valueForKey:@"photo"];
    UIImage *userPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userPhotoURL]]];
    [userManage setUserPhoto:userPhoto];
    
    //parse Trials.
    NSArray *trials = (NSArray *)[results valueForKey:@"trials"];
    [[userManage getUserTrials] removeAllObjects];
    
    for (int i = 0; i < [trials count]; i ++ ) {
        NSDictionary *trial = (NSDictionary *)trials[i];
        [[userManage getUserTrials] addObject:trial];
//        for (NSString *key in trial) {
//            if ([key isEqualToString:@"name"]) {
//                
//            } else if ([key isEqualToString:@"number"]) {
//                
//            } else if ([key isEqualToString:@"result"]) {
//                
//            } else if ([key isEqualToString:@"level"]) {
//                
//            } else if ([key isEqualToString:@"language"]) {
//                
//            } else if ([key isEqualToString:@"prompt_type"]) {
//                
//            }
//        }
    }
    
    //parse Clients.
    NSArray *clients = (NSArray *)[results valueForKey:@"clients"];
    [[userManage getUserClients] removeAllObjects];
    
    for (int i = 0 ; i <  [clients count]; i ++) {
        NSDictionary *client = (NSDictionary *)clients[i];
        [[userManage getUserClients] addObject:client];
    }
}

- (IBAction)onClickProceedGuest:(id)sender {
    [CommonUtils setGuestState:true];
    SetUp1ViewController* setup1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SetUp1ViewController"];
    [self.navigationController pushViewController:setup1ViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ( textField == _emailTextFiled) {
        [_passTextField becomeFirstResponder];
    } else if ( textField == _passTextField ) {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
