//
//  ServiceLayer.m
//  Hochu
//
//  Created by Andew Medvedev on 19.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "ServiceLayer.h"
#import "TransportLayer.h"

@interface ServiceLayer ()
@property (strong, nonatomic) TransportLayer* transportLayer;
@end


@implementation ServiceLayer

+ (ServiceLayer*)sharedService {
    static ServiceLayer* service = nil;
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[ServiceLayer alloc] init];
    });
    return service;
}

//--------------------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transportLayer = [[TransportLayer alloc]init];
    }
    return self;
}


//--------------------------------------------------------------------
- (void)openDialogIdForUser:(User*) user
                withSuccess:(void(^)(NSInteger dialogId)) success
                    failure:(FailureBlock) fail {
    
    [self.transportLayer
     openDialogIdForUser:user
     withSuccess:^(NSDictionary *params) {
         //
     } failure:^(NSError *error, NSInteger statusCode) {
         //
     }];
}

//--------------------------------------------------------------------
- (void)loadMessageHistoryForDialogId:(NSInteger)dialogId
                          withSuccess:(SuccessDictionaryBlock) success
                              failure:(FailureBlock) fail {
    
    [self.transportLayer
     loadMessageHistoryForDialogId:dialogId
     withSuccess:^(NSDictionary *params) {
         //
     } failure:^(NSError *error, NSInteger statusCode) {
         //
     }];
}

//--------------------------------------------------------------------
- (void)openNewDialogForUser:(User*) user
                     address:(NSString*) address
                 withSuccess:(void(^)(NSInteger dialogId)) success
                     failuer:(FailureBlock) fail {
    
    [self.transportLayer
     openNewDialogForUser:user
     address:address
     withSuccess:^(NSDictionary *params) {
         //
     } failuer:^(NSError *error, NSInteger statusCode) {
         //
     }];
}

//--------------------------------------------------------------------
- (void)sendMessage:(NSString*) message
           fromUser:(User*) user
           dialogId:(NSInteger) dialogId
        withSuccess:(CodeBlock) success
            failuer:(FailureBlock) fail {
    
    [self.transportLayer
     sendMessage:message
     fromUser:user
     dialogId:dialogId
     withSuccess:^(NSDictionary *params) {
         //
     } failuer:^(NSError *error, NSInteger statusCode) {
        //
     }];
}

//--------------------------------------------------------------------
- (void)closeDialog:(NSInteger) dialogId
        withSuccess:(CodeBlock) success
            failure:(FailureBlock) fail {
    
    [self.transportLayer
     closeDialog:dialogId
     withSuccess:^(NSDictionary *params) {
         //
     } failure:^(NSError *error, NSInteger statusCode) {
         //
     }];
}

@end
