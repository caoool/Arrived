//
//  UserService.m
//  Arrived
//
//  Created by Yetian Mao on 4/17/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

#import "UserService.h"
#define VERIFYUSER @"http://yetian.xyz/api/v1/users/verify"
#define REGISTERUSER @"http://yetian.xyz/api/v1/registerUser"
#define UPDATEUSER @"http://yetian.xyz/api/v1/users"

@implementation UserService

/**
 * Get User By Phone Number
 *
 * @parameter NSString *phoneNumber
 * @return NSDictionary
 */

-(void)getUserBy:(NSString *)phoneNumberId completion:(void (^)(NSDictionary *))completion{
    NSURLSession *getUserSession = [NSURLSession sharedSession];
    NSString *phoneNumberWithKey = [NSString stringWithFormat:@"phoneNumber=%@", phoneNumberId];
    NSString *url = @"http://edu.dev/api/v1/getUser?";
    url = [url stringByAppendingString:phoneNumberWithKey];
    NSURLSessionDataTask *dataTask = [getUserSession dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        
        if (!error && httpResp.statusCode == 200) {
            NSError *jsonError;
            _responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            completion(_responseData);
            NSLog(@"1%@", _responseData);
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [dataTask resume];
    
}

/**
 * Verification Process:
 * obtain a phoneNumberId and verification code
 *
 * @parameter NSString *phoneNumber
 * @return NSDictionary
 */

-(void)verify:(NSString *)phoneNumber completion:(void (^)(NSDictionary *))completion{
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
//    return _responseData;
    
}

/**
 * Perform Action On User Including update, register, auth
 *
 * @parameter NSString *url, NSString *method, NSDictionary *userInfo
 * @return NSDictionary
 */

-(void)actionOnUser:(NSString *) url httpMethod: (NSString *) method with:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion{
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
            completion(_responseData);
            NSLog(@"3%@", _responseData);
            
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [postUserTask resume];
}

/**
 * Register a User with BankInfo, pinCode, fullName
 *
 * @parameter NSDictionary *userInfo
 * @return NSDictionary
 */

-(void)registerWith:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion{
    [self actionOnUser:REGISTERUSER httpMethod:@"POST" with:userInfo completion:^(NSDictionary *response){
        completion(response);
    }];
}

/**
 * Update a User with optional Infomatiion such as nickname
 *
 * @parameter NSDictionary *userInfo
 * @return NSDictionary
 */

-(void)updateWith:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion{
    [self actionOnUser:UPDATEUSER httpMethod:@"PATCH" with:userInfo completion:^(NSDictionary *response){
        completion(response);
    }];
}

/**
 * Auth a User with phoneNumberID and verificationCode
 *
 * @parameter NSDictionary *userInfo
 * @return NSDictionary
 */

-(void)authWith:(NSDictionary *)userInfo completion:(void (^)(NSDictionary *))completion{
    [self actionOnUser:VERIFYUSER httpMethod:@"POST" with:userInfo completion:^(NSDictionary *response){
        completion(response);
    }];

}





@end
