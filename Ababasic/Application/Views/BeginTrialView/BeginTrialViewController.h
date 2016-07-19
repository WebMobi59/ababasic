//
//  BeginTrialViewController.h
//  Ababasic
//
//  Created by Superlight on 5/7/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface BeginTrialViewController : UIViewController<MFMailComposeViewControllerDelegate>

-(IBAction)trialDone:(id)sender;

-(void) changeImageOrder;

-(void) showResult;

@end

