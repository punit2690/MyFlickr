//
//  DetailViewController.m
//  MyFlickr
//
//  Created by Punit Kulkarni on 2/8/15.
//  Copyright (c) 2015 Punit Kulkarni. All rights reserved.
//

#import "DetailViewController.h"
#import "AsyncNSURLConnection.h"


@interface DetailViewController()<AsyncNSURLConnectionDelegate>
@property (nonatomic,strong) NSData *imageData;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@end

@implementation DetailViewController

//https://farm9.staticflickr.com/8641/15855179464_99cf16e841_m.jpg

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initModel];
    NSLog(@"%@",[self.feedItem.media objectForKey:[[self.feedItem.media allKeys]firstObject]]);
}

- (void)initModel {
    NSString *originalUrl = [self.feedItem.media objectForKey:[[self.feedItem.media allKeys]firstObject]];
    NSMutableArray *originalUrlParts = [[originalUrl componentsSeparatedByString:@"_"]mutableCopy];
    NSString *lastPart = [originalUrlParts lastObject];
    [originalUrlParts removeLastObject];
    NSArray *extensionArray = [lastPart componentsSeparatedByString:@"."];
    NSString *extensionString = [extensionArray lastObject];
    
    NSMutableString *imageUrl = [[NSMutableString alloc]init];
    imageUrl = (NSMutableString *)[originalUrlParts componentsJoinedByString:@"_"];
    imageUrl = [NSMutableString stringWithFormat:@"%@.%@",imageUrl,extensionString];
    
    NSLog(@"imageUrl: %@",imageUrl);
    AsyncNSURLConnection *connection = [[AsyncNSURLConnection alloc]initWithUrl:imageUrl forTask:@"GET_IMAGE_DATA" delegate:self];
    (void)connection;
    
}

- (IBAction)shareImage:(id)sender {
    if (self.imageData) {
        
    NSArray* dataToShare = @[self.imageData];
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
    }
}

- (void)didReceieveResponseObject:(id)responseObject ForTask:(NSString *)task {
    if (responseObject) {
        self.imageData = responseObject;
        [self.imageView setImage:[UIImage imageWithData:self.imageData]];
        [self.shareButton setEnabled:YES];
    }
}
@end
