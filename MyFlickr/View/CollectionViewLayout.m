//
//  CollectionViewLayout.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/7/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "CollectionViewLayout.h"

#define CELLWIDTH 140
#define CELLHEIGHT 195
@implementation CollectionViewLayout

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(CELLWIDTH, CELLHEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        [self setInterimSpacing];
    }
    return self;
}

- (void)setInterimSpacing {
    
    CGFloat interimSpacing = [self calculateInterimSpacing];
    self.minimumInteritemSpacing = interimSpacing;
    self.minimumLineSpacing = interimSpacing;
    self.sectionInset = UIEdgeInsetsMake(interimSpacing, interimSpacing, interimSpacing, interimSpacing);
}

- (CGFloat)calculateInterimSpacing {
    
    NSInteger numberOfItemsInRow = floorf([[UIScreen mainScreen]bounds].size.width/CELLWIDTH);
    CGFloat interimSpacing = ([[UIScreen mainScreen]bounds].size.width - (numberOfItemsInRow*CELLWIDTH))/(CGFloat)(numberOfItemsInRow+1);
    
    if (interimSpacing<10.0f) {
        --numberOfItemsInRow;
        interimSpacing = ([[UIScreen mainScreen]bounds].size.width - (numberOfItemsInRow*CELLWIDTH))/(CGFloat)(numberOfItemsInRow+1);
    }

    return interimSpacing;
}

@end
