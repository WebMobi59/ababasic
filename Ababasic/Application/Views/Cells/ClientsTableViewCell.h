//
//  ClientsTableViewCell.h
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *clientPhoto;
@property (weak, nonatomic) IBOutlet UILabel *clientName, *clientDiagnosis, *clientCompany;

@end
