//
//  UserProfileViewController.h
//  Ababasic
//
//  Created by MobileStar on 6/22/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *userPhotoBtn;
@property (weak, nonatomic) IBOutlet UITextField *diagnosisEdit;
@property (weak, nonatomic) IBOutlet UITextField *schoolEdit;
@property (weak, nonatomic) IBOutlet UIScrollView *userProfileScrollView;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *diagnosisLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCreditsBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *birthdayBtn;

@end
