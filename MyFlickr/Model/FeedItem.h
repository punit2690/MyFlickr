//
//  FeedItem.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FeedItemDelegate <NSObject>

@required
- (void)didReceieveDataForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FeedItem : NSObject

@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSDictionary *media;
@property (nonatomic,strong) NSString *dateTaken;
@property (nonatomic,strong) NSString *feedDescription;
@property (nonatomic,strong) NSString *published;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *authorId;
@property (nonatomic,strong) NSArray *tags;
@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,strong) NSData *buddyImageData;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) NSString *farm;
@property (nonatomic,strong) NSString *iconServer;
@property (nonatomic,strong) NSString *alias;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)willDisplayFeedItemForIndexPath:(NSIndexPath *)indexPath;
- (void)dellocMemoryForImages;

@end
