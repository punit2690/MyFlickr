//
//  WebServiceResponseNotification.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/7/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceResponseNotification : NSObject

@property (nonatomic,copy) NSString *tag;
@property (nonatomic,getter=isSuccessful,assign) BOOL successful;

- (BOOL)isSuccessful;

@end
