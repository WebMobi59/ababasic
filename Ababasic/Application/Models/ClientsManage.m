//
//  ClientsManage.m
//  Ababasic
//
//  Created by MobileStar on 6/29/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import "ClientsManage.h"

static NSString *first_name;
static NSString *last_name;
static NSString *birthday;
static NSString *diagnosis;
static NSString *school;
static NSString *photo_url;

@implementation ClientsManage

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void) setFirstName:(NSString *)first { first_name = first; }

- (NSString *) getFirstName { return first_name; }

- (void) setLastName:(NSString *)last { last_name = last; }

- (NSString *) getLastName { return last_name; }

- (void) setBirthday:(NSString *)day { birthday = day; }

- (NSString *) getBirthday { return birthday; }

- (void) setDiagnosis:(NSString *)diag { diagnosis = diag; }

- (NSString *) getDiagnosis { return diagnosis; }

- (void) setSchool:(NSString *)sc { school = sc; }

- (NSString *) getSchool { return school; }

- (void) setPhoto:(NSString *)url { photo_url = url; }

- (NSString *) getPhoto { return photo_url; }

@end