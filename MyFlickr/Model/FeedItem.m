//
//  FeedItem.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "FeedItem.h"
#import "NSDictionary+safe.h"
#import "KeyConstants.h"
#import "AsyncNSURLConnection.h"
#import "WebServiceAPI.h"

@interface FeedItem()<AsyncNSURLConnectionDelegate>

@end
@implementation FeedItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if ((self = [super self])) {
        _link = [dict safeObjectForKey:KEY_FEED_ITEM_LINK];
        _media = [dict safeObjectForKey:KEY_FEED_ITEM_MEDIA];//dictionary
        _dateTaken = [dict safeObjectForKey:KEY_FEED_ITEM_DATE];
        _feedDescription = [dict safeObjectForKey:KEY_FEED_ITEM_DESCRIPTION];
        _published = [dict safeObjectForKey:KEY_FEED_ITEM_PUBLISHED];
        _author = [dict safeObjectForKey:KEY_FEED_ITEM_AUTHOR];
        _authorId = [dict safeObjectForKey:KEY_FEED_ITEM_AUTHOR_ID];
        _tags = [[dict safeObjectForKey:KEY_FEED_ITEM_TAGS]componentsSeparatedByString:@" "];
        
        if (_authorId) {
            [AsyncNSURLConnection initAsyncRequestForURL:[WebServiceAPI getPeopleInfoForUserId:_authorId]
                                                 forTask:@"GET_AUTHOR_INFO"
                                                delegate:self];
        }
    }
    
    return self;
}

- (void)willDisplayFeedItemForIndexPath:(NSIndexPath *)indexPath {
    if (!self.imageData) {
        if ([self.media objectForKey:([[self.media allKeys]count]>0)?[[self.media allKeys]objectAtIndex:0]:@""]) {
            self.indexPath = indexPath;
            AsyncNSURLConnection *asyncNSURLConnection = [[AsyncNSURLConnection alloc]initWithUrl:[self.media objectForKey:([[self.media allKeys]count]>0)?[[self.media allKeys]objectAtIndex:0]:@""]
                                         forTask:@"GET_ITEM_IMAGE" delegate:self];
            (void)asyncNSURLConnection;
        }
    }
    
    if (!self.buddyImageData) {
        if (self.authorId && self.farm && self.iconServer) {
            AsyncNSURLConnection *asyncNSURLConnection1 = [[AsyncNSURLConnection alloc]initWithUrl:[WebServiceAPI getBuddyIconUrlForBuddyInFarm:self.farm iconServer:self.iconServer nsid:self.authorId]
                                                                                           forTask:@"GET_BUDDY_IMAGE" delegate:self];
            (void)asyncNSURLConnection1;
        }
    }
}

- (void)didReceieveResponseObject:(id)responseObject
                          ForTask:(NSString *)task {
    if ([task isEqualToString:@"GET_ITEM_IMAGE"]) {
        if (responseObject) {
            self.imageData = responseObject;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CellDataReady"
                                                               object:self.indexPath];
        }
    }
    
    if ([task isEqualToString:@"GET_BUDDY_IMAGE"]) {
        if (responseObject) {
            self.buddyImageData = responseObject;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CellDataReady"
                                                               object:self.indexPath];
        }
    }
    
    if ([task isEqualToString:@"GET_AUTHOR_INFO"]) {
        if (responseObject) {
            _iconServer = [[responseObject safeObjectForKey:@"person"]objectForKey:@"iconserver"];
            _farm = [[responseObject safeObjectForKey:@"person"]objectForKey:@"iconfarm"];
            _alias = [[responseObject safeObjectForKey:@"person"]objectForKey:@"path_alias"];
        }
    }
}

- (void)dellocMemoryForImages {
    
}

@end
