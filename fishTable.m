//
//  fishTable.m
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "fishTable.h"
#import "Fish.h"
#import "FishDetaailViewController.h"

@interface fishTable ()
@property(strong)NSArray *fish;

@end

@implementation fishTable
@synthesize adView;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fish" ofType:@"plist"];
    NSArray *Array = [[NSArray alloc] initWithContentsOfFile:path];
    //NSMutableArray *myArr = [[NSMutableArray alloc] init];
    lake = [NSMutableArray array];
    
    for(int i = 0; i < 82; i++) {
        int x = 5 * i;
        Fish *f1 = [[Fish alloc] initWithFname:[Array objectAtIndex:x] locations:[Array objectAtIndex:(x+1)] description:[Array objectAtIndex:(x+2)] photo:[UIImage imageNamed:[Array objectAtIndex:(x+3)]] thumb:[UIImage imageNamed:[Array objectAtIndex:(x+4)]]];
        [lake addObject:f1];
    }
   
    self.fish = lake;
    
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    adView.hidden = FALSE;
    NSLog(@"Has as showing");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    adView.hidden = TRUE;
    NSLog(@"No ad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"FIshDetailSegue"]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *ip = [self.tableView indexPathForCell:cell];
        Fish *f;
        FishDetaailViewController *pdvc = (FishDetaailViewController *)segue.destinationViewController;;
        if(ip.section == 1){
            int num = (int)ip.row + 27;
            f = [self.fish objectAtIndex:num];
        } else if(ip.section == 2) {
            int num = (int)ip.row + 60;
            f = [self.fish objectAtIndex:num];
        } else {
            f = [self.fish objectAtIndex:ip.row];
        }
        pdvc.fish = f;
    }
}


#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Lakes";
            break;
        case 1:
            return @"Oceans";
            break;
        case 2:
            return @"Rivers";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 27;
            break;
        case 1:
            return 33;
            break;
        case 2:
            return 22;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    Fish *f2;
    
    if(indexPath.section == 1){
        int number = (int)indexPath.row +27;
       f2 = [self.fish objectAtIndex:number];
    }else if(indexPath.section == 2){
        int number = (int)indexPath.row +60;
        f2 = [self.fish objectAtIndex:number];
    }
    else {
        f2 = [self.fish objectAtIndex:indexPath.row];
    }
    //UIImageView *imageViews = [[UIImageView alloc] initWithImage:f2.photo];
    //imageViews.frame = CGRectMake(6.5, 6.5, 25.0, 25.0);
    //[cell addSubview:imageView];
    cell.imageView.image = f2.thumb;
    cell.textLabel.text = f2.fname;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
