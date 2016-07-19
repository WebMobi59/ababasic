//
//  EditClientViewController.m
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "EditClientViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SetUp1ViewController.h"
#import "YourClientsViewController.h"
#import "WYPopoverController.h"
#import "WYSettingsViewController.h"

@interface EditClientViewController ()<UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate, WYPopoverControllerDelegate, UINavigationControllerDelegate>{
    WYPopoverController *settingsPopoverController;
    WYSettingsViewController *settingViewController;
}
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UITextField *firstName, *lastInitial, *diagnosis, *company;
@property (weak, nonatomic) IBOutlet UIButton *saveClientButton, *profileButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *birthdayBtn;



@end

static UIImage *clientImage;

@implementation EditClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

#pragma mark - init
-(void)initUI{
    [commonUtils setRoundedRectBorderImage:_profilePhoto withBorderWidth:0.1f withBorderColor:[UIColor clearColor] withBorderRadius:60.0f];
    [commonUtils setTextFieldBorder:_firstName withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_lastInitial withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_diagnosis withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setTextFieldBorder:_company withColor:[UIColor grayColor] withBorderWidth:1.0f withCornerRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_saveClientButton withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_birthdayBtn withBorderWidth:0.1f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [_scrollView setContentSize:CGSizeMake(_scrollView.layer.frame.size.width, 500)];
    clientImage = [UIImage imageNamed:@"create_client.png"];
}

- (IBAction)profileButtonClicked:(id)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Take a Photo", @"Choose from Library" ,nil];
    [actionSheet showInView:self.view];
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

//// Image Picker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!resultImage) {
            resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }

        [self.profilePhoto setImage:resultImage];
        clientImage = resultImage;

    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveClientButtonClicked:(id)sender {
    NSData *imageData = UIImageJPEGRepresentation(clientImage, 1.0f);
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"],
                                 @"first_name":self.firstName.text,
                                 @"last_name":self.lastInitial.text,
                                 @"birthday":self.birthdayBtn.titleLabel.text,
                                 @"diagnosis":self.diagnosis.text,
                                 @"school":self.company.text};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://52.26.92.41/api/v1/clients" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"photo" fileName:@"profile.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary *)responseObject;
        if ([[responseData valueForKey:@"status"] isEqualToString:@"success"]) {
            YourClientsViewController *viewClientsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"YourClientsViewController"];
            [self.navigationController pushViewController:viewClientsVC animated:YES];
        } else {
            [commonUtils showVAlertSimple:@"Notice" body:(NSString *)[responseData valueForKey:@"data"] duration:1.2];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [commonUtils showVAlertSimple:@"Notice" body:@"Internet connection is failed. Try it again later" duration:1.2];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _firstName) {
        [_lastInitial becomeFirstResponder];
    } else if (textField == _lastInitial) {
        [_diagnosis becomeFirstResponder];
    }  else if ( textField == _diagnosis ) {
        [_company becomeFirstResponder];
    } else if (textField == _company) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
