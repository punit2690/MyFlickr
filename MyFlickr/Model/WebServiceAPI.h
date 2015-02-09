//
//  WebServiceAPI.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceAPI : NSObject

+ (NSString *)getPublicFeedAPIforPage:(NSInteger)page;
+ (NSString *)getPeopleInfoForUserId:(NSString *)userId;
+ (NSString *)getBuddyIconUrlForBuddyInFarm:(NSString *)farm iconServer:(NSString *)iconServer nsid:(NSString *)userId;

@end
