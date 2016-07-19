//
//  LaunchScreenViewController.m
//  Ababasic
//
//  Created by MobileStar on 6/26/16.
//  Copyright © 2016 Superlight. All rights reserved.
//

#import "LaunchScreenViewController.h"

@implementation LaunchScreenViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _markLabel.layer.borderWidth = 2.0f;
    _markLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _markLabel.layer.cornerRadius = 5.0f;
    
    [self fadein];
}

-(void) fadein
{
    _markLabel.alpha = 0;
    [UIView animateWithDuration:3.0f animations:^{
        [_markLabel setAlpha:1.0f];
    } completion:^(BOOL finished){
        UINavigationController* firstController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationViewControllerIdentifier"];
        [self presentViewController:firstController animated:YES completion:nil];
    }];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:3];
//    _markLabel.alpha = 1;
//    [UIView commitAnimations];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished    context:(void *)context {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    _markLabel.alpha = 0;
    [UIView commitAnimations];
}


@end
