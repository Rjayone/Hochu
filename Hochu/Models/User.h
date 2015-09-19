//
//  User.h
//  Hochu
//
//  Created by Andew Medvedev on 19.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "BaseEntity.h"

@interface User : BaseEntity

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) NSString* address;

@end
