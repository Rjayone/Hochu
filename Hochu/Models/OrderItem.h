//
//  OrderItem.h
//  Hochu
//
//  Created by Andrew Medvedev on 28/09/15.
//  Copyright © 2015 Andew Medvedev. All rights reserved.
//

#import "BaseEntity.h"

@interface OrderItem : BaseEntity

@property (strong, nonatomic) NSURL*    image;
@property (strong, nonatomic) NSString* itemTitle;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger price;

@end
