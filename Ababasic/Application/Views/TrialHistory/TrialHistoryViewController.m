//
//  TrialHistoryViewController.m
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "TrialHistoryViewController.h"
#import "SetUp1ViewController.h"

@interface TrialHistoryViewController ()
@property (weak, nonatomic) IBOutlet UIButton *trialNewSession, *goBack;
@property (weak, nonatomic) IBOutlet UIView *history;

@property (weak, nonatomic) IBOutlet UILabel *clientName;
@end

@implementation TrialHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initUI{
    [commonUtils setRoundedRectBorderButton:_trialNewSession withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_goBack withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectView:_history withCornerRadius:25.0f];
    _clientName.text=appController.clientName;
}

- (IBAction)goBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)newSessionClicked:(id)sender {
    SetUp1ViewController *setup1ViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SetUp1ViewController"];
    [self.navigationController pushViewController:setup1ViewController animated:YES];
    
}
@end
