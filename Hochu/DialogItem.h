//
//  DialogItem.h
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#import "Common.h"

@interface DialogItem : BaseEntity

@property (strong, nonatomic) NSString* message;
@property (assign, nonatomic) MessageType type;

@end
