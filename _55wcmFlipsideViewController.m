//
//  _55wcmFlipsideViewController.m
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "_55wcmFlipsideViewController.h"
#import "photoGame.h"

@interface _55wcmFlipsideViewController ()

@end

@implementation _55wcmFlipsideViewController

@synthesize delegate;
@synthesize choicesControl;
@synthesize lakesSwitch;
@synthesize riversSwitch;
@synthesize oceansSwitch;
@synthesize adView;


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Actions

- (IBAction)done:(id)sender
{
    if (!lakesSwitch.on && !riversSwitch.on && !oceansSwitch.on) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select at least one region" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	} else {
		int index = (int)[choicesControl selectedSegmentIndex];
       
		[(photoGame *)self.delegate setGuessRows:index + 1];
		
		NSMutableDictionary *regions = [(photoGame *)self.delegate waters];
		[regions setValue:[NSNumber numberWithBool:lakesSwitch.on] forKey:@"Lakes"];
		[regions setValue:[NSNumber numberWithBool:riversSwitch.on] forKey:@"Rivers"];
		[regions setValue:[NSNumber numberWithBool:oceansSwitch.on] forKey:@"Oceans"];
		
		[(photoGame *)self.delegate resetQuiz];
		[self.delegate flipsideViewControllerDidFinish:self];
	}
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    adView.hidden = FALSE;
    NSLog(@"Has as showing");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    adView.hidden = TRUE;
    NSLog(@"No ad");
}
- (void)setSwitches:(NSDictionary *)dictionary
{
	[lakesSwitch setOn:[[dictionary valueForKey:@"Lakes"] boolValue]];
	[riversSwitch setOn:[[dictionary valueForKey:@"Rivers"] boolValue]];
	[oceansSwitch setOn:[[dictionary valueForKey:@"Oceans"] boolValue]];
}

- (void)setSelectedIndex:(int)index
{
	choicesControl.selectedSegmentIndex = index;
}

@end
