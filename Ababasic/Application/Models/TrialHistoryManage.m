//
//  TrialHistoryManage.m
//  Ababasic
//
//  Created by MobileStar on 6/29/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import "TrialHistoryManage.h"

static NSString *name;
static int number;
static int result;
static NSString *level;
static NSString *language;
static NSString *prompt_level;
static NSDate *trial_time;

@implementation TrialHistoryManage

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void) setName:(NSString *)n { name = n; }

- (NSString *) getName { return name; }

- (void) setNumbers:(int)nums { number = nums; }

- (int) getNumbers { return number; }

- (void) setResult:(int)nums { result = nums; }

- (int) getResult { return result; }

- (void) setLevel:(NSString *)l { level = l; }

- (NSString *) getLevel { return level; }

- (void) setPromptType:(NSString *)w { prompt_level = w; }

- (NSString *) getPromptType { return prompt_level; }

- (void) setTrialTime:(NSDate *)d { trial_time = d; }

- (NSDate *) getTrialTime { return trial_time; }

@end
