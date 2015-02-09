//
//  CustomCollectionViewCell.h
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface CustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *buddyImageView;

@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@end
