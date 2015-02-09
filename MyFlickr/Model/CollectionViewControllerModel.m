//
//  CollectionViewControllerModel.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "CollectionViewControllerModel.h"
#import "AsyncNSURLConnection.h"
#import "WebServiceAPI.h"
#import "KeyConstants.h"
#import "FeedItem.h"

@interface CollectionViewControllerModel()<AsyncNSURLConnectionDelegate>

@end

@implementation CollectionViewControllerModel {
    NSInteger page;
}

- (instancetype)init {
    if (self = [super init]) {
        page = 1;
        [AsyncNSURLConnection initAsyncRequestForURL:[WebServiceAPI getPublicFeedAPIforPage:page]
                                             forTask:@"GET_PUBLIC_FEED"
                                            delegate:self];
    }
    return self;
}

- (void)loadNextPage {
    ++page;
    [AsyncNSURLConnection initAsyncRequestForURL:[WebServiceAPI getPublicFeedAPIforPage:page]
                                         forTask:@"GET_PUBLIC_FEED"
                                        delegate:self];
}

- (void)getInfoForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.feed getInfoForItemAtIndexPath:indexPath];
}

- (void)didReceieveResponseObject:(id)responseObject ForTask:(NSString *)task {
    
    if ([task isEqualToString:@"GET_PUBLIC_FEED"]) {
        if (responseObject) {
            if (!_feed) {
                _feed = [[Feed alloc]initWithResponse:responseObject];
                NSLog(@"feed: %lu",(unsigned long)[self.feed.feedItems count]);
            } else {
                for (NSDictionary *dict in [responseObject objectForKey:KEY_FEED_ITEMS]) {
                    FeedItem *feedItem = [[FeedItem alloc]initWithDict:dict];
                    [self.feed.feedItems addObject:feedItem];
                }
            }
        } else {
            
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WebServiceResponseRecieved" object:@{@"TASK":task,@"SUCCESS":[NSNumber numberWithBool:(responseObject)?YES:NO]}];
    }
}




@end
