//  AppController.h
//  Created by BE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppController : NSObject

@property (nonatomic, strong) NSMutableArray *introSliderImages;
@property (nonatomic, strong) NSMutableDictionary *currentUser, *apnsMessage;
@property (nonatomic, strong) NSMutableArray *barks, *myBarks, *likedBarks, *menuPages, *avatars, *favoriteUsers, *statsPeriods;
@property (nonatomic, strong) UIImage *postBarkImage, *editProfileImage;

// Temporary Variables
@property (nonatomic, strong) NSString *currentMenuTag, *avatarUrlTemp, *facebookPhotoUrlTemp;
@property (nonatomic, strong) NSMutableDictionary *currentNavBark, *currentNavBarkStat;
@property (nonatomic, assign) BOOL isFromSignUpSecondPage, isNewBarkUploaded, isMyProfileChanged;
@property (nonatomic, strong) NSString *statsVelocityHistoryPeriod;
@property (nonatomic, strong) UIImage *image1, *image2, *image3;
@property (nonatomic, strong) NSString *promLevel;
@property (nonatomic, strong) NSString *langLevel;

@property (nonatomic, assign) int trialCount;
@property (nonatomic, strong) NSString *clientName;


// Utility Variables
@property (nonatomic, strong) UIColor *appMainColor, *appTextColor, *appThirdColor;
@property (nonatomic, strong) DoAlertView *vAlert;

+ (AppController *)sharedInstance;

@end