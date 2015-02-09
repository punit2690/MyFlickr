//
//  DetailViewController.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/8/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface DetailViewController : UIViewController

@property (nonatomic,strong) FeedItem *feedItem;

@end
