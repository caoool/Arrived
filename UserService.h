//
//  UserService.h
//  Arrived
//
//  Created by Yetian Mao on 4/17/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserService : NSObject

@property (nonatomic, strong) NSDictionary *responseData;

-(void)verify:(NSString *)phoneNumber completion:(void (^)(NSDictionary *))completion;

-(void)getUserBy:(NSString *)phoneNumberId completion:(void (^)(NSDictionary *))completion;

-(void)registerWith:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion;

-(void)updateWith:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion;

-(void)authWith:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion;


@end
