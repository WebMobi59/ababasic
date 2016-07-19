//
//  DashboardViewController.m
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "DashboardViewController.h"
#import "LoginViewController.h"
#import "EditClientViewController.h"
#import "YourClientsViewController.h"

@interface DashboardViewController ()
@property (weak, nonatomic) IBOutlet UIButton *createClientButton, *viewClientsButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [commonUtils setRoundedRectBorderButton:_createClientButton withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [commonUtils setRoundedRectBorderButton:_viewClientsButton withBorderWidth:1.0f withBorderColor:[UIColor grayColor] withBorderRadius:5.0f];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, 500)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logoutButtonClicked:(id)sender {
    LoginViewController *loginViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)createClientButtonClicked:(id)sender {
    EditClientViewController *editClientViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"EditClientViewController"];
    [self.navigationController pushViewController:editClientViewController animated:YES];
}
- (IBAction)viewClientsButtonClicked:(id)sender {
    YourClientsViewController *yourClientsViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"YourClientsViewController"];
    [self.navigationController pushViewController:yourClientsViewController animated:YES];
}

@end
