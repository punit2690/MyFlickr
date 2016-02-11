//
//  CustomCollectionViewCell.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell()
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@end

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

    self.buddyImageView.layer.cornerRadius = self.buddyImageView.bounds.size.width/2;
    self.buddyImageView.clipsToBounds = YES;
    self.layer.cornerRadius = 10.0f;
    self.clipsToBounds = YES;
}
@end
