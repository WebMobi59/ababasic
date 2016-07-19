//
//  SignUpViewController.m
//  Ababasic
//
//  Created by Superlight on 4/21/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "SignUpViewController.h"
#import "UserProfileViewController.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField, *userTypeField, *emailField, *passField, *confirmPassField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton, *proceedGuestButton;
@property (weak, nonatomic) IBOutlet UIScrollView *SignUpScrollView;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [commonUtils setTextFieldBorder:_nameField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_userTypeField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_emailField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_passField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_confirmPassField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_signupButton withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_proceedGuestButton withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    
    [_SignUpScrollView setContentSize:CGSizeMake(_SignUpScrollView.frame.size.width, 500)];
    
}

- (IBAction)onSignUpClicked:(id)sender {
    NSDictionary *parameters = @{@"email"       :self.emailField.text,
                                 @"password"    :self.passField.text,
                                 @"name"        :self.nameField.text,
                                 @"user_type"   :self.userTypeField.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://52.26.92.41/api/v1/accounts/create" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary *)responseObject;
        if ([[responseData valueForKey:@"status"] isEqualToString:@"success"]) {
            
            NSString *token = (NSString *)[responseData valueForKey:@"data"];
            [userManage setUserToken:token];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"UserToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [CommonUtils setGuestState:false];
            
            UserProfileViewController* userProfileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
            [self.navigationController pushViewController:userProfileVC animated:YES];
        } else {
            [commonUtils showVAlertSimple:@"Notice" body:(NSString *)[responseData valueForKey:@"data"] duration:1.2];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [commonUtils showVAlertSimple:@"Notice" body:@"Internet connection is failed. Try it again later" duration:1.2];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
- (IBAction)onGuestBtnClick:(id)sender {
    [CommonUtils setGuestState:true];
}

- (IBAction)onBackButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nameField) {
        [_userTypeField becomeFirstResponder];
    } else if (textField == _userTypeField) {
        [_emailField becomeFirstResponder];
    } else if ( textField == _emailField ) {
        [_passField becomeFirstResponder];
    } else if ( textField == _passField ) {
        [_confirmPassField becomeFirstResponder];
    } else if (textField == _confirmPassField) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
