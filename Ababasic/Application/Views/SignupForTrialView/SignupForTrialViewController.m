//
//  SignupForTrialViewController.m
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "SignupForTrialViewController.h"
#import "DashboardViewController.h"

@interface SignupForTrialViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField, *userTypeField, *emailField, *passField, *confirmPassField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton,*goBackButton;

@end

@implementation SignupForTrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [commonUtils setTextFieldBorder:_nameField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_userTypeField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_emailField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_passField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_confirmPassField withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_signupButton withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_goBackButton withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onBackButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signupButtonClicked:(id)sender {
    DashboardViewController *dashboardViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    [self.navigationController pushViewController:dashboardViewController animated:YES];
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
