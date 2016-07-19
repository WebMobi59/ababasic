//
//  AddImageViewController.m
//  Ababasic
//
//  Created by Superlight on 4/24/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "AddImageViewController.h"
#import "SelectTargetViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface AddImageViewController ()<UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textContent;
@property (weak, nonatomic) IBOutlet UIImageView *image1, *image2, *image3;
@property (weak, nonatomic) IBOutlet UIButton *button1, *button2, *button3, *selectTarget;
@end

BOOL first, second, third;
int flag;

@implementation AddImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectTarget.hidden = YES;
    [commonUtils setRoundedRectBorderImage:_image1 withBorderWidth:0.1f withBorderColor:[UIColor clearColor] withBorderRadius:10.0f];
    [commonUtils setRoundedRectBorderImage:_image2 withBorderWidth:0.1f withBorderColor:[UIColor clearColor] withBorderRadius:10.0f];
    [commonUtils setRoundedRectBorderImage:_image3 withBorderWidth:0.1f withBorderColor:[UIColor clearColor] withBorderRadius:10.0f];
    [commonUtils setRoundedRectBorderButton:_selectTarget withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
    
    first = second = third = NO;
    flag = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)image1_clicked:(id)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Use Camera", @"Choose from Photos" ,nil];
    
    flag = 1;
    
    [actionSheet showInView:self.view];

}
- (IBAction)image2_clicked:(id)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Use Camera", @"Choose from Photos" ,nil];
    
    flag = 2;
    
    [actionSheet showInView:self.view];
    
}
- (IBAction)image3_clicked:(id)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Use Camera", @"Choose from Photos" ,nil];
    
    flag = 3;
    
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
        if(flag == 1){
            first = YES;
            [self.image1 setImage:resultImage];
            appController.image1=resultImage;
        }else if (flag == 2){
            second = YES;
            [self.image2 setImage:resultImage];
            appController.image2=resultImage;
        }else if ( flag == 3 ) {
            third = YES;
            [self.image3 setImage:resultImage];
            appController.image3=resultImage;
        }
        
        if ( first && second && third ) {
            _selectTarget.hidden = NO;
            _textContent.text = @"Tap a square to insert items";
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectTargetButtonClicked:(id)sender {
    SelectTargetViewController* selectTargetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectTargetViewController"];
    [self.navigationController pushViewController:selectTargetViewController animated:YES];
}

@end
