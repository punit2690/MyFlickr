//
//  WebServiceAPI.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "WebServiceAPI.h"

@implementation WebServiceAPI

NSString *const API_KEY = @"448fe6316d1e232fcd3b5a50586e42b6";
NSString *const SECRET = @"7ea8caf61ccad437";
NSString *const baseUrl = @"https://api.flickr.com/services";

/*
 https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
 
 https://farm9.staticflickr.com/8641/15855179464_99cf16e841_m.jpg
	or
 https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
	or
 https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
 */

+ (NSString *)getPublicFeedAPIforPage:(NSInteger)page {
    NSLog(@"Url: %@",[baseUrl stringByAppendingString: [NSString stringWithFormat:@"/feeds/photos_public.gne?format=json&nojsoncallback=1&page=%ld",(long)page]]);
    return [baseUrl stringByAppendingString: [NSString stringWithFormat:@"/feeds/photos_public.gne?format=json&nojsoncallback=1&page=%ld&safe_search=1",(long)page]];
}

+ (NSString *)getBuddyIconUrlForBuddyInFarm:(NSString *)farm iconServer:(NSString *)iconServer nsid:(NSString *)userId {
    return [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",farm,iconServer,userId];
}

+ (NSString *)getPeopleInfoForUserId:(NSString *)userId {
    return [ NSString stringWithFormat: @"https://api.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=%@&user_id=%@&format=json&nojsoncallback=1", API_KEY,userId];
}


@end
