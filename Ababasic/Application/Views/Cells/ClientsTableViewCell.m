//
//  ClientsTableViewCell.m
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "ClientsTableViewCell.h"

@implementation ClientsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [commonUtils setRoundedRectBorderImage:_clientPhoto withBorderWidth:1.0f withBorderColor:[UIColor clearColor] withBorderRadius:25.0f];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
