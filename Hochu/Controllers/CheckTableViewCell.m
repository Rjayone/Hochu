//
//  CheckTableViewCell.m
//  Hochu
//
//  Created by Andew Medvedev on 20.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "CheckTableViewCell.h"


@implementation CheckTableViewCell

- (void)awakeFromNib {
    self.background.layer.cornerRadius = 5.f;
    self.background.layer.borderColor = [[UIColor redColor]CGColor];
    self.background.layer.borderWidth = 0.5f;
}

- (void)configureCellWithParams:(NSDictionary*)params {
    
}

- (IBAction)noButtonClicked:(UIButton *)sender {
}

- (IBAction)confirmButtonClicked:(UIButton *)sender {
}
@end
