//
//  CollectionViewControllerModel.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@interface CollectionViewControllerModel : NSObject

@property (nonatomic,strong) Feed *feed;

- (void)getInfoForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadNextPage;

@end
