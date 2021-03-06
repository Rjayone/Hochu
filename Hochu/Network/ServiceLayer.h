//
//  ServiceLayer.h
//  Hochu
//
//  Created by Andew Medvedev on 19.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceLayer : NSObject

+ (ServiceLayer*)sharedService;


//Описание:
//Метод возвращает ид открытого диалога, если 0, то диалога с таким пользователем не существует
- (void)openDialogIdForUser:(User*) user
                withSuccess:(void(^)(NSInteger dialogId)) success
                    failure:(FailureBlock) fail;

//Описание:
//Метод возвращает массив всех сообщений с пользователем
- (void)loadMessageHistoryForDialogId:(NSInteger)dialogId
                          withSuccess:(SuccessDictionaryBlock) success
                              failure:(FailureBlock) fail;

//Описание:
//Метод создает новый диалог. В ответе ид нового диалога
- (void)openNewDialogForUser:(User*) user
                     address:(NSString*) address
                 withSuccess:(void(^)(NSInteger dialogId)) success
                     failuer:(FailureBlock) fail;

//Описание:
//Метод отправляет сообщение от юзера по определенному ид диалога
- (void)sendMessage:(NSString*) message
           fromUser:(User*) user
           dialogId:(NSInteger) dialogId
        withSuccess:(CodeBlock) success
            failuer:(FailureBlock) fail;

//Описание:
//Метод закрывает диалог по определенному ид
- (void)closeDialog:(NSInteger) dialogId
        withSuccess:(CodeBlock) success
            failure:(FailureBlock) fail;
@end
