//
//  NSDictionary+safe.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safe)

- (id)safeObjectForKey:(NSString *)key;

@end
