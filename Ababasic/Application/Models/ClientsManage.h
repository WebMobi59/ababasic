//
//  ClientsManage.h
//  Ababasic
//
//  Created by MobileStar on 6/29/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientsManage : NSObject

+ (instancetype)shared;

- (void) setFirstName : (NSString *)first;

- (NSString *) getFirstName;

- (void) setLastName : (NSString *)last;

- (NSString *) getLastName;

- (void) setBirthday : (NSString *) day;

- (NSString *) getBirthday;

- (void) setDiagnosis : (NSString *)diag;

- (NSString *) getDiagnosis;

- (void) setSchool : (NSString *) sc;

- (NSString *) getSchool;

- (void) setPhoto : (NSString *) url;

- (NSString *) getPhoto;

@end
