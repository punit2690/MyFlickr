//
//  CollectionViewController.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/5/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewControllerModel.h"
#import "CustomCollectionViewCell.h"
#import "NSDictionary+safe.h"
#import "CollectionViewLayout.h"
#import "UIImage+AverageColor.h"
#import "DetailViewController.h"

@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITraitEnvironment>

@property (nonatomic,strong) CollectionViewControllerModel *collectionViewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation CollectionViewController {
    BOOL isLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initModel];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(webServiceResponseRecieved:)
                                                name:@"WebServiceResponseRecieved"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(cellDataReady:)
                                                name:@"CellDataReady"
                                              object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    isLoading = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //Dispose FeedItem.imageData and FeedItem.buddyImageData for all cells except IndexpathsForVisibleCells
    for (NSUInteger i=0; i<[self.collectionViewModel.feed.feedItems count]; i++) {
        NSArray *visibleItems = [self.collectionView indexPathsForVisibleItems];
        NSMutableArray *visibleItemIndexes = [[NSMutableArray alloc]init];
        
        for (NSIndexPath *indexPath in visibleItems) {
            [visibleItemIndexes addObject:[NSNumber numberWithInteger:indexPath.item]];
        }
        
        if (![visibleItemIndexes containsObject:[NSNumber numberWithInteger:i]]) {
            ((FeedItem *)[self.collectionViewModel.feed.feedItems objectAtIndex:i]).imageData = nil;
            ((FeedItem *)[self.collectionViewModel.feed.feedItems objectAtIndex:i]).buddyImageData = nil;
        }
    }
}


//-----------------------------------------------------
#pragma mark PrepareForSegue
//-----------------------------------------------------
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [super prepareForSegue:segue sender:self];
    if ([segue.identifier isEqualToString:@"segueShowDetailView"]) {
        
        DetailViewController *detailViewController = (DetailViewController *)[segue destinationViewController];
        detailViewController.feedItem = [self.collectionViewModel.feed.feedItems objectAtIndex:((NSIndexPath *)[[self.collectionView indexPathsForSelectedItems]firstObject]).item];
        [self.collectionView deselectItemAtIndexPath:(NSIndexPath *)[[self.collectionView indexPathsForSelectedItems]firstObject] animated:NO];
    }
}


//-----------------------------------------------------
#pragma mark Init Methods
//-----------------------------------------------------

- (void)initModel {
    
    _collectionViewModel = [[CollectionViewControllerModel alloc]init];
    isLoading = NO;
}

- (void)initUI {
    _collectionView.collectionViewLayout = [[CollectionViewLayout alloc]init];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.backgroundImageView setImage:[UIImage imageNamed:@"large.jpg"]];

}

//-----------------------------------------------------
#pragma mark Observer Methods
//-----------------------------------------------------
- (void)webServiceResponseRecieved:(NSNotification *)notification {
    if ([[notification.object safeObjectForKey:@"TASK"]isEqualToString:@"GET_PUBLIC_FEED"]) {
        if ([[notification.object safeObjectForKey:@"SUCCESS"]boolValue]) {
            [self.collectionView reloadData];
            isLoading = NO;
        } else {
            
        }
    }
}

- (void)cellDataReady:(NSNotification *)notification {
    NSIndexPath *indexPath = (NSIndexPath *)notification.object;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

//-----------------------------------------------------
#pragma mark UICollectionViewDelegate Methods
//-----------------------------------------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.collectionViewModel.feed.feedItems count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                    forIndexPath:indexPath];
    [self.collectionViewModel getInfoForItemAtIndexPath:indexPath];
    [self setCellDataForCell:cell atIndexpath:indexPath];
    return cell;
}

- (void)setCellDataForCell: (CustomCollectionViewCell *)customCollectionViewCell atIndexpath:(NSIndexPath *)indexPath{
    
    FeedItem *feedItem = (FeedItem *)[self.collectionViewModel.feed.feedItems objectAtIndex:indexPath.item];
    
    if (feedItem.imageData) {
        
        UIImage *cellImage = [UIImage imageWithData:feedItem.imageData];
        [customCollectionViewCell.imageView setImage:cellImage];
        UIColor *backgroundColor = [UIColor colorWithPatternImage:cellImage];
        [customCollectionViewCell.titleView setBackgroundColor:backgroundColor];
        
        CGFloat red;
        CGFloat blue;
        CGFloat green;
        CGFloat alpha;

        [[cellImage averageColor] getRed:&red green:&green blue:&blue alpha:&alpha];
        
        red= (red>0.5)?1:0;
        green= (green>0.5)?1:0;
        blue= (blue>0.5)?1:0;

        [customCollectionViewCell.aliasLabel setTextColor:[UIColor colorWithRed:1-red green:1-green blue:1-blue alpha:1.0]];
        
        if ([indexPath isEqual:(NSIndexPath *)[[self.collectionView indexPathsForVisibleItems]firstObject]]) {
            [self.collectionView setBackgroundColor:[UIColor colorWithPatternImage:cellImage]];
        }
    }
    
    else {
        
        [customCollectionViewCell.titleView setBackgroundColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [customCollectionViewCell.aliasLabel setTextColor:[UIColor blackColor]];

        [customCollectionViewCell.imageView setImage:nil];
    }
    
    if (feedItem.buddyImageData) {
        
        UIImage *buddyImage = [UIImage imageWithData:feedItem.buddyImageData];
        [customCollectionViewCell.buddyImageView setImage:buddyImage];
    }
    
    else {
        
        [customCollectionViewCell.buddyImageView setImage:[UIImage imageNamed:@"default-user-icon.png"]];
    }
    
    if (![feedItem.alias isKindOfClass:[NSNull class]]) {
        [customCollectionViewCell.aliasLabel setText:feedItem.alias];
    }
    
    else {
        [customCollectionViewCell.aliasLabel setText:@""];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    

}

//-----------------------------------------------------
#pragma mark ScrollView Method
//-----------------------------------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scroll {

    CGFloat currentOffset = scroll.contentOffset.y;
    CGFloat maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
    
    if (fabs(maximumOffset - currentOffset) <= 150 && isLoading == NO) {
            [self.collectionViewModel loadNextPage];
            isLoading = YES;
    }
}

//-----------------------------------------------------
#pragma mark Rotation Method
//-----------------------------------------------------

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    [(CollectionViewLayout *)self.collectionView.collectionViewLayout setInterimSpacing];
}
@end
