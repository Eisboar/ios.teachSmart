//
//  HttpClient.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 10/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject <NSURLSessionDataDelegate>

- (void)sendHTTPPost;

@end
