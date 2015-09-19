//
//  ChatTableViewCell.h
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *background;

@end
