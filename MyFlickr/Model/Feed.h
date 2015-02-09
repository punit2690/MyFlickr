//
//  Feed.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *feedDescription;
@property (nonatomic,strong) NSString *modified;
@property (nonatomic,strong) NSString *generator;
@property (nonatomic,strong) NSMutableArray *feedItems;

- (instancetype)initWithResponse:(id)responseObject;
- (void)getInfoForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
