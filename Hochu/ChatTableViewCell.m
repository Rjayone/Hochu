//
//  ChatTableViewCell.m
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    self.background.layer.cornerRadius = 5.f;
}

- (void)configureCellWithParams:(NSDictionary*)params {
    
}

@end
