//
//  TrialHistoryManage.h
//  Ababasic
//
//  Created by MobileStar on 6/29/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrialHistoryManage : NSObject

+ (instancetype)shared;

- (void) setName:(NSString *)n;
- (NSString *) getName;

- (void) setNumbers:(int)nums;
- (int) getNumbers;

- (void) setResult:(int)nums;
- (int) getResult;

- (void) setLevel:(NSString *)level;
- (NSString *) getLevel;

- (void) setLanguage:(NSString *)lang;
- (NSString *) getLanguage;

- (void) setPromptType:(NSString *)w;
- (NSString *) getPromptType;

- (void) setTrialTime:(NSDate *)d;
- (NSDate *) getTrialTime;

@end
