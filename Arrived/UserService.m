//
//  UserService.m
//  Arrived
//
//  Created by Yetian Mao on 4/17/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

#import "UserService.h"
#define VERIFYUSER @"http://edu.dev/api/v1/postUser"
#define REGISTERUSER @"http://edu.dev/api/v1/registerUser"
#define UPDATEUSER @"http://edu.dev/api/v1/users"

@implementation UserService

/**
 * Get User By Phone Number
 *
 * @parameter NSString *phoneNumber
 * @return NSDictionary
 */

-(NSDictionary *)getUserBy:(NSString *)phoneNumber{
    NSURLSession *getUserSession = [NSURLSession sharedSession];
    NSString *phoneNumberWithKey = [NSString stringWithFormat:@"phoneNumber=%@", phoneNumber];
    NSString *url = @"http://edu.dev/api/v1/getUser?";
    url = [url stringByAppendingString:phoneNumberWithKey];
    NSURLSessionDataTask *dataTask = [getUserSession dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        
        if (!error && httpResp.statusCode == 200) {
            NSError *jsonError;
            _responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSLog(@"%@", _responseData);
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [dataTask resume];
    return _responseData;
}

/**
 * Verification Process:
 * obtain a phoneNumberId and verification code
 *
 * @parameter NSString *phoneNumber
 * @return NSDictionary
 */

-(NSDictionary *)verify:(NSString *)phoneNumber{
    NSURLSession *verifySession = [NSURLSession sharedSession];
    NSMutableURLRequest *postUserRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:VERIFYUSER]];
    postUserRequest.HTTPMethod = @"POST";
    NSString *phoneNumberWithKey = [NSString stringWithFormat:@"phoneNumber=%@", phoneNumber];
    NSData *postData = [phoneNumberWithKey dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)phoneNumber.length];
    [postUserRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-type"];
    [postUserRequest setValue:postLength forHTTPHeaderField: @"Content-Length"];
    [postUserRequest setValue:@"application/json" forHTTPHeaderField: @"Accept"];

    
    NSURLSessionUploadTask *postUserTask = [verifySession
                                             uploadTaskWithRequest:postUserRequest
                                             fromData:postData
                                             completionHandler:^(NSData *data,
                                                                 NSURLResponse *response,
                                                                 NSError *error)
    {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        
        if (!error && httpResp.statusCode == 200) {
            NSError *jsonError;
            _responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSLog(@"%@", _responseData);
            
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [postUserTask resume];

    return _responseData;
                                     
}

/**
 * Perform Action On User Including update, register, auth
 *
 * @parameter NSString *url, NSString *method, NSDictionary *userInfo
 * @return NSDictionary
 */

-(NSDictionary *)actionOnUser:(NSString *) url httpMethod: (NSString *) method with:(NSDictionary *)userInfo{
    NSURLSession *verifySession = [NSURLSession sharedSession];
    NSMutableURLRequest *postUserRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    postUserRequest.HTTPMethod = method;
    NSError *jsonError;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:userInfo options:0 error:&jsonError];
    [postUserRequest setValue:@"application/json" forHTTPHeaderField: @"Content-type"];
    [postUserRequest setValue:@"application/json" forHTTPHeaderField: @"Accept"];
    NSURLSessionUploadTask *postUserTask = [verifySession
                                            uploadTaskWithRequest:postUserRequest
                                            fromData:postData
                                            completionHandler:^(NSData *data,
                                                                NSURLResponse *response,
                                                                NSError *error)
    {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        
        if (!error && httpResp.statusCode == 200) {
            NSError *jsonError;
            _responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSLog(@"%@", _responseData);
            
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [postUserTask resume];
    
    return _responseData;
}

/**
 * Register a User with BankInfo, pinCode, fullName
 *
 * @parameter NSDictionary *userInfo
 * @return NSDictionary
 */

-(NSDictionary *)registerWith:(NSDictionary *)userInfo{
    return [self actionOnUser:VERIFYUSER httpMethod:@"POST" with:userInfo];
}

/**
 * Update a User with optional Infomatiion such as nickname
 *
 * @parameter NSDictionary *userInfo
 * @return NSDictionary
 */

-(NSDictionary *)updateWith:(NSDictionary *)userInfo{
    return [self actionOnUser:VERIFYUSER httpMethod:@"PATCH" with:userInfo];
}

/**
 * Auth a User with phoneNumberID and verificationCode
 *
 * @parameter NSDictionary *userInfo
 * @return NSDictionary
 */

-(NSDictionary *)authWith:(NSDictionary *)userInfo{
    return [self actionOnUser:VERIFYUSER httpMethod:@"POST" with:userInfo];
}





@end
