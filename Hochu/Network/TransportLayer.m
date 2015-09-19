//
//  TransportLayer.m
//  Hochu
//
//  Created by Andew Medvedev on 19.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "TransportLayer.h"
#import "AFNetworking.h"

@interface TransportLayer ()
@property (strong, nonatomic) AFHTTPRequestOperationManager* manager;
@end


//--------------------------------------------------------------------
@implementation TransportLayer
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}


#pragma mark - Transport implaments
//--------------------------------------------------------------------
- (void)openDialogIdForUser:(User*) user
                withSuccess:(SuccessDictionaryBlock) success
                    failure:(FailureBlock) fail {
    
    NSDictionary* params = @{ @"phone" : user ? user.phoneNumber : @"" };
    [self.manager POST:@"get_open_dialog.php"
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  success(responseObject);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  fail(error, error.code);
              }];
}

//--------------------------------------------------------------------
- (void)loadMessageHistoryForDialogId:(NSInteger)dialogId
                          withSuccess:(SuccessDictionaryBlock) success
                              failure:(FailureBlock) fail {
    
    NSDictionary* params = @{ @"dialogID" : @(dialogId) };
    
    [self.manager POST:@"load"
            parameters:params
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   success(responseObject);
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   fail(error, error.code);
               }];
    
}

//--------------------------------------------------------------------
- (void)openNewDialogForUser:(User*) user
                     address:(NSString*) address
                 withSuccess:(SuccessDictionaryBlock) success
                     failuer:(FailureBlock) fail {
    
    NSDictionary* params = @{ @"phone" : user ? user.phoneNumber : @"",
                              @"address" : user ? user.address : @""
                              };

    [self.manager POST:@"new_dialog.php"
            parameters:params
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSString* serverResponse = [[NSString alloc]initWithData:responseObject encoding:4];
                   success(responseObject);
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   fail(error, error.code);
               }];
    
}

//--------------------------------------------------------------------
- (void)sendMessage:(NSString*) message
           fromUser:(User*) user
           dialogId:(NSInteger) dialogId
        withSuccess:(SuccessDictionaryBlock) success
            failuer:(FailureBlock) fail {
    
    NSDictionary* params = @{ @"author" : user ? user.phoneNumber : @"",
                              @"data" : message ? : @"",
                              @"dialogID" : @(dialogId)
                              };
    
    [self.manager POST:@"get_open_dialog"
            parameters:params
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   success(responseObject);
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   fail(error, error.code);
               }];
    
}

//--------------------------------------------------------------------
- (void)closeDialog:(NSInteger) dialogId
        withSuccess:(SuccessDictionaryBlock) success
            failure:(FailureBlock) fail {
    
    NSDictionary* params = @{ @"dialogID" : @(dialogId)};
    
    [self.manager POST:@"get_open_dialog"
            parameters:params
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   success(responseObject);
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   fail(error, error.code);
               }];
    
}

@end
