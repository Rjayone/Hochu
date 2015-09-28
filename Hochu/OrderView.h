//
//  OrderView.h
//  Hochu
//
//  Created by Andrew Medvedev on 28/09/15.
//  Copyright © 2015 Andew Medvedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderItem;

@interface OrderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

- (void)configureViewWithOrderItem:(OrderItem*)item;
@end
