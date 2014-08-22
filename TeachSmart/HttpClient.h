//
//  HttpClient.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 10/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

@protocol NetworkCallback <NSObject>

@required
- (void) receiveNetworkCallback:(NSDictionary *)networkResponse;
@end


@interface HttpClient : NSObject <NSURLSessionDataDelegate>
{
    //id <NetworkCallback> _delegate;
}

@property (nonatomic, strong) id <NetworkCallback> receiverDelegate;
@property NSString *responseString;

@property (nonatomic) NetworkTasks task;
@property (nonatomic) NSData* requestJsonData;

- (void)sendHTTPPost;
@end
