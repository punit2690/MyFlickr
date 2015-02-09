//
//  AsyncNSURLConnection.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyncNSURLConnectionDelegate <NSObject>

@required

- (void)didReceieveResponseObject:(id)responseObject ForTask:(NSString *)task;

@end

@interface AsyncNSURLConnection : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,strong) id<AsyncNSURLConnectionDelegate> delegate;

- (instancetype)initWithUrl:(NSString *)url
                    forTask:(NSString *)task
                   delegate:(id<AsyncNSURLConnectionDelegate>) delegate;

+ (void)initAsyncRequestForURL:(NSString *)url
                   forTask:(NSString *)task
                      delegate:(id<AsyncNSURLConnectionDelegate>)delegate;
@end
