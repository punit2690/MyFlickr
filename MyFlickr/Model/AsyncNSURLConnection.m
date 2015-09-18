//
//  AsyncNSURLConnection.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "AsyncNSURLConnection.h"

@implementation AsyncNSURLConnection {
    NSMutableData *responseData;
    NSString *taskName;
}

+ (void)initAsyncRequestForURL:(NSString *)url
                       forTask:(NSString *)task
                      delegate:(id<AsyncNSURLConnectionDelegate>)delegate {
    
    NSURL *URL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:requestURL
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:[AsyncNSURLConnection tempFixForValidJSONFromNSData:data]
                                                                                            options:kNilOptions
                                                                                              error:&error];
                               NSLog(@"JSON Receieved: %@",[responseDict description]);
                               [delegate didReceieveResponseObject:responseDict
                                      ForTask:task];
                           }];
}

- (instancetype)initWithUrl:(NSString *)url
                    forTask:(NSString *)task
                   delegate:(id<AsyncNSURLConnectionDelegate>) delegate {


    if (self = [super init]) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        (void)urlConnection;
        taskName = [NSString stringWithString:task];
        responseData = [[NSMutableData alloc] init];
        _delegate = delegate;
        
    }
    return self;
}

+ (NSMutableData *)tempFixForValidJSONFromNSData:(NSData *)jsonData {
    
    NSMutableString *jsonString = [[NSMutableString alloc] initWithData:jsonData
                                                        encoding:NSUTF8StringEncoding];
    jsonData = nil;
    return [[[jsonString stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"] dataUsingEncoding:NSUTF8StringEncoding]mutableCopy];
}

//-----------------------------------------------------
#pragma mark NSURLConnection delegate methods
//-----------------------------------------------------

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"TASK:%@ Connection Success",taskName);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"TASK:%@ Request Success",taskName);
    NSError *error;

    if (error) {
        NSLog(@"ERROR: Error in serialization. %@",[error description]);
        responseData = nil;

    } else {
        [self.delegate didReceieveResponseObject:responseData
                                         ForTask:taskName];
        responseData = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"TASK:%@ Request Failed",taskName);
    [self.delegate didReceieveResponseObject:nil ForTask:taskName];
    responseData = nil;
}

- (void)dealloc {
    NSLog(@"dealloc called for object for task: %@",taskName);
}
@end
