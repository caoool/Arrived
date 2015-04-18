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

-(NSDictionary *)verify:(NSString *)phoneNumber;

-(NSDictionary *)getUserBy:(NSString *)phoneNumberId;

-(NSDictionary *)registerWith:(NSDictionary *)userInfo;

-(NSDictionary *)updateWith:(NSDictionary *)userInfo;




@end
