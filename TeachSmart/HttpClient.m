//
//  HttpClient.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 10/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "HttpClient.h"
#import "constants.h"

@interface HttpClient(){
    NSMutableDictionary *networkResponse;
    
}

@end

@implementation HttpClient 

+ (NSDictionary *)createTaskStrings
{
    return @{@(getSheet) : @"getSheet",
             @(getSheets) : @"getSheets"};
}

- (NSString *)convertTasktoString
{
    return [[self class] createTaskStrings][@(self.task)];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler 1");
    
    completionHandler(NSURLSessionResponseAllow);
}


/*
 
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    //NSLog(@"fired!");
    [networkResponse setObject:data forKey:@"jsonData"];
    self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received String %@",self.responseString);
    
    
    [self.receiverDelegate receiveNetworkCallback:networkResponse];
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        [networkResponse setObject:@(NO) forKey:@"error"];
           //self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Download is Succesfull");
        //NSLog(@"Received String %@",self.responseString);
    }
    else {
        NSLog(@"Error %@",[error userInfo]);
        [networkResponse setObject:@(YES) forKey:@"error"];
        [self.receiverDelegate receiveNetworkCallback:networkResponse];
    }


}

-(void) sendHTTPPost
{
    //NSLog(@"test1");
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];

    NSString* urlString = baseURL;
    urlString = [urlString stringByAppendingString:[self convertTasktoString]];

    NSURL * url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    //NSString * params =@"";
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[NSDictionary dictionaryWithObjectsAndKeys:
                                        @"application/json", @"Content-Type",nil]];
    [urlRequest setHTTPBody:_requestJsonData];
    networkResponse = [[NSMutableDictionary alloc] init];
    [networkResponse setObject:[NSNumber numberWithInt:_task] forKey:@"task"];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    [dataTask resume];
}


@end
