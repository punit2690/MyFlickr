//
//  NSDictionary+safe.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "NSDictionary+safe.h"

@implementation NSDictionary (safe)

- (id)safeObjectForKey:(NSString *)key{
    
    id obj = [self objectForKey:key];
    if([obj isKindOfClass:[NSNull class]]){
        return nil;
    }
    else{
        return obj;
    }
}

@end
