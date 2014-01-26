//
//  ViewController.m
//  WildKingdomPart2
//
//  Created by John Malloy on 1/24/14.
//  Copyright (c) 2014 Big Red INC. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#define flickrAPI @"c187929476cd969b9153e579038a4692"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITabBarControllerDelegate,UITabBarDelegate>
{
    NSDictionary * results;
    NSArray * pictures;

    __weak IBOutlet UICollectionView *collectionView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



-(void) getFlickrImages
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=10&page=1&format=json&nojsoncallback=1&auth_token=72157640145075196-32da8ae19b28ed94&api_sig=bad939194c945eeffe13a736996a7751", @"c187929476cd969b9153e579038a4692", _searchString]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     
     {
         pictures  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"photos"][@"photo"];
         pictures = results[@"photos"];
         
         
         NSLog(@"We got something %@", pictures);
         
         
         [collectionView reloadData];
         
         
     }];

}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    _searchString = @"";
    _searchString = item.title;
    
    [self getFlickrImages];
}







-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}



- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    {
        CustomCollectionViewCell * cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
        results = pictures [indexPath.row];
        
        NSString * url = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",results[@"farm"],results[@"server"],results[@"id"],results[@"secret"]];
        
        cell.imageView.image = [UIImage imageNamed:@"DPP_0072.jpg"];
        return cell;
    }
}

@end
