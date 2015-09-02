//
//  FishViewController.m
//  yyyy
//
//  Created by william murphy on 1/9/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "FishViewController.h"

@interface FishViewController ()

@end

@implementation FishViewController
@synthesize fnameLabel,desLabel,locLabel,fish;
@synthesize adView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.fnameLabel.text = self.fish.fname;
    self.desLabel.text = self.fish.description;
    self.locLabel.text = self.fish.locations;
    self.photoImage.image = self.fish.photo;
    
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

@end
