//
//  Common.h
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageTypeFrom,
    MessageTypeTo,
    MessageTypeCheck
} MessageType;


//Данная строка используется для доступа к API
static NSString* baseURL = @"http://estory.by/hochu.by/client/";


//Blocks
typedef void(^FailureBlock)(NSError *error, NSInteger statusCode);
typedef void(^SuccessArrayBlock)(NSArray* items);
typedef void(^SuccessDictionaryBlock)(NSDictionary* params);
typedef void(^CodeBlock)(NSInteger code);

@interface Common : NSObject
@end
