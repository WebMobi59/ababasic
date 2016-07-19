//
//  UserManage.m
//  Ababasic
//
//  Created by MobileStar on 6/29/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import "UserManage.h"
#import "TrialHistoryManage.h"
#import "ClientsManage.h"

static NSString *user_id;
static NSString *user_email;
static NSString *user_password;
static NSString *user_name;
static NSString *user_type;
static NSString *user_token;
static NSString *user_birthday;
static NSString *user_diagnosis;
static NSString *user_school;
static UIImage *photo_url;
static NSMutableArray *trials;
static NSMutableArray *clients;

@implementation UserManage

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    trials = [[NSMutableArray alloc] init];
    clients = [[NSMutableArray alloc] init];
    return self;
}

- (void) setUserId:(NSString *)uid { user_id = uid; }

- (NSString *) getUserId { return user_id; }

- (void) setUserName:(NSString *)name { user_name = name; }

- (NSString *) getUserName { return user_name; }

- (void) setUserEmailAddress : (NSString *)e_address { user_email = e_address; }

- (NSString *) getUserEmailAddress { return user_email; }

- (void) setUserPassword:(NSString *)pwd { user_password = pwd; }

- (NSString *) getUserPassword { return user_password; }

- (void) setUserType:(NSString *)type { user_type = type; }

- (NSString *) getUserType { return user_type; }

- (void) setUserBirthday:(NSString *)day { user_birthday = day; }

- (NSString *) getUserBirthday { return user_birthday; }

- (void) setUserDiagnosis:(NSString *)diag { user_diagnosis = diag; }

- (NSString *) getUserDiagnosis { return user_diagnosis; }

- (void) setUserSchool:(NSString *)sc { user_school = sc; }

- (NSString *) getUserSchool { return user_school; }

- (void) setUserPhoto:(UIImage *)url { photo_url = url; }

- (UIImage *) getUserPhoto { return photo_url; }

- (void) setUserTrials:(NSMutableArray *)array { trials = array; }

- (NSMutableArray *) getUserTrials { return trials; }

- (void) setUserClients:(NSMutableArray *)array { clients = array; }

- (NSMutableArray *) getUserClients { return clients;}

- (void) setUserToken:(NSString *)token { user_token = token; }

- (NSString *) getUserToken { return user_token; }

@end
