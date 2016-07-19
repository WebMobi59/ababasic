//
//  UserManage.h
//  Ababasic
//
//  Created by MobileStar on 6/29/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManage : NSObject

+ (instancetype)shared;

- (void) setUserId : (NSString *)uid;

- (NSString *) getUserId;

- (void) setUserName : (NSString *)name;

- (NSString *) getUserName;

- (void) setUserEmailAddress : (NSString *) e_address;

- (NSString *) getUserEmailAddress;

- (void) setUserPassword : (NSString *)pwd;

- (NSString *) getUserPassword;

- (void) setUserType : (NSString *)type;

- (NSString *) getUserType;

- (void) setUserBirthday : (NSString *) day;

- (NSString *) getUserBirthday;

- (void) setUserDiagnosis : (NSString *)diag;

- (NSString *) getUserDiagnosis;

- (void) setUserSchool : (NSString *) sc;

- (NSString *) getUserSchool;

- (void) setUserPhoto : (UIImage *) url;

- (UIImage *) getUserPhoto;

- (void) setUserToken : (NSString *)token;

- (NSString *) getUserToken;

- (void) setUserTrials : (NSMutableArray *)array;

- (NSMutableArray *) getUserTrials;

- (void) setUserClients : (NSMutableArray *)array;

- (NSMutableArray *) getUserClients;

@end
