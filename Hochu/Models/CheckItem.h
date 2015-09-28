//
//  CheckItem.h
//  Hochu
//
//  Created by Andrew Medvedev on 28/09/15.
//  Copyright © 2015 Andew Medvedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckItem : BaseEntity

@property (assign, nonatomic) MessageType type;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* phone;
@property (assign, nonatomic) NSInteger totalPrice;
@property (strong, nonatomic) NSArray* orderItems;      //Array of OrderItem

@end
