//
//  UserProfileViewController.m
//  Ababasic
//
//  Created by MobileStar on 6/22/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import "UserProfileViewController.h"
#import "SetUp1ViewController.h"
#import "TrialHistoryViewController.h"
#import "DashboardViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "WYPopoverController.h"
#import "WYSettingsViewController.h"

@interface UserProfileViewController ()<UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, WYPopoverControllerDelegate, UIGestureRecognizerDelegate>{

    WYPopoverController *settingsPopoverController;
    WYSettingsViewController *settingViewController;
}

@end

static UIImage *userImage;

@implementation UserProfileViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [_userProfileScrollView setContentSize:CGSizeMake(_userProfileScrollView.frame.size.width, 500)];
    [self initUI];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    settingsPopoverController.delegate = nil;
    settingsPopoverController = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)initUI{
    [commonUtils setRoundedRectBorderButton:_userPhotoBtn withBorderWidth:0.1f withBorderColor:[UIColor clearColor] withBorderRadius:_userPhotoBtn.layer.frame.size.width / 2.0];
    [commonUtils setRoundedRectBorderButton:_purchaseCreditsBtn withBorderWidth:0.1f withBorderColor:[UIColor clearColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_birthdayBtn withBorderWidth:0.1f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    
    userImage = [userManage getUserPhoto];
    if (!userImage) {
        userImage = [UIImage imageNamed:@"create_client.png"];
    }
    
    [self.userPhotoBtn setImage:userImage forState:UIControlStateNormal];
    
    if ([userManage getUserBirthday]) {
        [self.birthdayLabel setText:[userManage getUserBirthday]];
    } else {
        [self.birthdayLabel setText:@""];
    }
    
    if ([userManage getUserDiagnosis]) {
        [self.diagnosisLabel setText:[userManage getUserDiagnosis]];
    } else {
        [self.diagnosisLabel setText:@""];
    }
    
    if ([userManage getUserSchool]) {
        [self.schoolLabel setText:[userManage getUserSchool]];
    } else {
        [self.schoolLabel setText:@""];
    }
    
    self.birthdayBtn.hidden = true;
    self.diagnosisEdit.hidden = true;
    self.schoolEdit.hidden = true;
    
    self.birthdayLabel.hidden = false;
    self.diagnosisLabel.hidden = false;
    self.schoolLabel.hidden = false;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == _diagnosisEdit) {
        [_schoolEdit becomeFirstResponder];
    } else if (textField == _schoolEdit) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)editProcess:(id)sender {
    __block UIButton *btn = (UIButton *)sender;
    if ( [btn.titleLabel.text  isEqual: @"Edit"] ) {
        self.birthdayLabel.hidden = true;
        self.diagnosisLabel.hidden = true;
        self.schoolLabel.hidden = true;
        
        self.birthdayBtn.hidden = false;
        self.diagnosisEdit.hidden = false;
        self.schoolEdit.hidden = false;
        [btn setTitle:@"Save" forState:UIControlStateNormal];
    } else {
        NSData *imageData = UIImageJPEGRepresentation(userImage, 1.0f);
        if (!self.birthdayBtn.titleLabel.text) [self.birthdayBtn.titleLabel setText:@""];
        if (!self.diagnosisEdit.text) [self.diagnosisEdit setText:@""];
        if (!self.schoolEdit.text) [self.schoolEdit setText:@""];
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] stringForKey:@"UserToken"],
                                     @"birthday":self.birthdayBtn.titleLabel.text,
                                     @"diagnosis":self.diagnosisEdit.text,
                                     @"school":self.schoolEdit.text};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://52.26.92.41/api/v1/accounts/setup" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"photo" fileName:@"profile.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *responseData = (NSDictionary *)responseObject;
            if ([[responseData valueForKey:@"status"] isEqualToString:@"success"]) {
                
                [userManage setUserPhoto:userImage];
                
                [self.birthdayLabel setText:self.birthdayBtn.titleLabel.text];
                [self.diagnosisLabel setText:self.diagnosisEdit.text];
                [self.schoolLabel setText:self.schoolEdit.text];
                
                self.birthdayLabel.hidden = false;
                self.diagnosisLabel.hidden = false;
                self.schoolLabel.hidden = false;
                
                self.birthdayBtn.titleLabel.hidden = true;
                self.diagnosisEdit.hidden = true;
                self.schoolEdit.hidden = true;
                [btn setTitle:@"Edit" forState:UIControlStateNormal];
            } else {
                [commonUtils showVAlertSimple:@"Notice" body:(NSString *)[responseData valueForKey:@"data"] duration:1.2];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [commonUtils showVAlertSimple:@"Notice" body:@"Internet connection is failed. Try it again later" duration:1.2];
        }];
    }
}

- (IBAction)backProcess:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)userPhotoClick:(id)sender {
    if ( [self.editBtn.titleLabel.text isEqualToString:@"Save"] ) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Take a Photo", @"Choose from Library" ,nil];
        [actionSheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self onAddImageFromCamera];
    }else if (buttonIndex == 1)
    {
        [self onAddImageFromLibrary];
    }
    
}
- (void)onAddImageFromCamera
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    pickerController.allowsEditing = NO;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}


- (void)onAddImageFromLibrary
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    pickerController.allowsEditing = NO;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!resultImage) {
            resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        [self.userPhotoBtn setImage:resultImage forState:UIControlStateNormal];
        userImage = resultImage;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareClientBtnClick:(id)sender {
    DashboardViewController* dashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    [self.navigationController pushViewController:dashboardVC animated:YES];
}

- (IBAction)howtoBtnClick:(id)sender {
}

- (IBAction)newBtnClick:(id)sender {
    SetUp1ViewController* setup1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SetUp1ViewController"];
    [self.navigationController pushViewController:setup1ViewController animated:YES];

}
- (IBAction)historyBtnClick:(id)sender {
    TrialHistoryViewController *historyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TrialHistoryViewController"];
    [self.navigationController pushViewController:historyVC animated:YES];
}
- (IBAction)purchaseCreditsBtnClick:(id)sender {
}

- (IBAction)birthdayBtnClick:(id)sender {
    if (settingsPopoverController == nil)
    {
        UIView *btn = (UIView *)sender;
        
        settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WYSettingsViewController"];
        
        settingViewController.title = @"Choose Birthday";
        
        [settingViewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)]];
        
        [settingViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close:)]];
        
        settingViewController.modalInPopover = NO;
        
        UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
        
        settingsPopoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        settingsPopoverController.delegate = self;
        settingsPopoverController.passthroughViews = @[btn];
        settingsPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        settingsPopoverController.wantsDefaultContentAppearance = NO;

            [settingsPopoverController presentPopoverFromRect:btn.bounds
                                                       inView:btn
                                     permittedArrowDirections:WYPopoverArrowDirectionAny
                                                     animated:YES
                                                      options:WYPopoverAnimationOptionFadeWithScale];

    }
    else
    {
        [self close:nil];
    }
}

- (void)close:(id)sender
{
    [settingsPopoverController dismissPopoverAnimated:YES completion:^{
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy/MM/dd"];
        NSString *result = [df stringFromDate:settingViewController.birthdayPicker.date];
        [self.birthdayBtn setTitle:result forState:UIControlStateNormal];
        [self popoverControllerDidDismissPopover:settingsPopoverController];
    }];
}

- (void)cancel:(id)sender
{
    [settingsPopoverController dismissPopoverAnimated:YES completion:^{
        [self popoverControllerDidDismissPopover:settingsPopoverController];
    }];
}

@end
