//
//  SelectTargetViewController.m
//  Ababasic
//
//  Created by Superlight on 4/25/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "SelectTargetViewController.h"
#import "BeginTrialViewController.h"

@interface SelectTargetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image1, *image2, *image3;
@property (weak, nonatomic) IBOutlet UIButton *button1, *button2, *button3, *beginTrialButton;

@end

@implementation SelectTargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.image1 setImage:appController.image1];
    [self.image2 setImage:appController.image2];
    [self.image3 setImage:appController.image3];
    [commonUtils setRoundedRectBorderButton:_beginTrialButton withBorderWidth:1 withBorderColor:[UIColor grayColor] withBorderRadius:5];
    [commonUtils setRoundedRectBorderImage:_image1 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image2 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image3 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    
    _beginTrialButton.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1Clicked:(id)sender {
    [CommonUtils setAnswer:0];
    
    [commonUtils setRoundedRectBorderImage:_image1 withBorderWidth:3 withBorderColor:[UIColor redColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image2 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image3 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    
    _beginTrialButton.hidden=NO;
}

- (IBAction)button2Clicked:(id)sender {
    [CommonUtils setAnswer:1];
    
    [commonUtils setRoundedRectBorderImage:_image1 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image2 withBorderWidth:3 withBorderColor:[UIColor redColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image3 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    
    _beginTrialButton.hidden=NO;
    
}

- (IBAction)button3Clicked:(id)sender {
    [CommonUtils setAnswer:2];
    
    [commonUtils setRoundedRectBorderImage:_image1 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image2 withBorderWidth:3 withBorderColor:[UIColor whiteColor] withBorderRadius:5.0];
    [commonUtils setRoundedRectBorderImage:_image3 withBorderWidth:3 withBorderColor:[UIColor redColor] withBorderRadius:5.0];
    
    _beginTrialButton.hidden=NO;
    
}

- (IBAction)beginTrialButtonClicked:(id)sender {
    BeginTrialViewController* beginTrialViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BeginTrialViewController"];
    [self.navigationController pushViewController:beginTrialViewController animated:YES];
}

@end
