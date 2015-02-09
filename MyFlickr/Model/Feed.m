//
//  Feed.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "Feed.h"
#import "FeedItem.h"
#import "NSDictionary+safe.h"
#import "KeyConstants.h"
#import <UIKit/UIKit.h>

@implementation Feed

- (instancetype)initWithResponse:(id)responseObject {
    
    if (self = [super init]) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            _title = [responseObject safeObjectForKey:KEY_FEED_TITLE];
            _link  = [responseObject safeObjectForKey:KEY_FEED_LINK];
            _feedDescription = [responseObject safeObjectForKey:KEY_FEED_DESCRIPTION];
            _modified = [responseObject safeObjectForKey:KEY_FEED_MODIFIED];
            _generator = [responseObject safeObjectForKey:KEY_FEED_GENERATOR];
            _feedItems = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in [responseObject safeObjectForKey:KEY_FEED_ITEMS]) {
                FeedItem *feedItem = [[FeedItem alloc]initWithDict:dict];
                [_feedItems addObject:feedItem];
            }
        }
    }
    
    return self;
}

- (void)getInfoForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item < [self.feedItems count]) {
        [(FeedItem *)[self.feedItems objectAtIndex:indexPath.item]willDisplayFeedItemForIndexPath:indexPath];
    } else {
        NSLog(@"ERROR: Info requested for non existent Feed Item.");
    }
}

@end
