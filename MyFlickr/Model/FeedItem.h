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
- (void)didReceiveDataForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FeedItem : NSObject

@property (nonatomic,copy) NSString *link;
@property (nonatomic,strong) NSDictionary *media;
@property (nonatomic,copy) NSString *dateTaken;
@property (nonatomic,copy) NSString *feedDescription;
@property (nonatomic,copy) NSString *published;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *authorId;
@property (nonatomic,strong) NSArray *tags;
@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,strong) NSData *buddyImageData;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,copy) NSString *farm;
@property (nonatomic,copy) NSString *iconServer;
@property (nonatomic,copy) NSString *alias;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)willDisplayFeedItemForIndexPath:(NSIndexPath *)indexPath;
- (void)dellocMemoryForImages;

@end
