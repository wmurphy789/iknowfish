//
//  photoGame.m
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "photoGame.h"
static const int BAR_OFFSET = 250;

@implementation photoGame

@synthesize fishView;
@synthesize answerLabel;
@synthesize numberCorrectLabel,adView;


- (void)viewDidLoad
{
	[super viewDidLoad];
	srandom((int)time(0));
	[answerLabel setText:nil];
	[numberCorrectLabel setText:@"Question 1 of 10"];
	
    guessRows = 1;
    bars = [[NSMutableArray alloc] init];
    filenames = [[NSMutableArray alloc] init];
    FishQuiz = [[NSMutableArray alloc] initWithCapacity:10];
    waters = [[NSMutableDictionary alloc] init];
    NSNumber *yesBool = [NSNumber numberWithBool:YES];
    [waters setValue:yesBool forKey:@"Lakes"];
    [waters setValue:yesBool forKey:@"Rivers"];
    [waters setValue:yesBool forKey:@"Oceans"];
    
	NSMutableArray *paths = [[[NSBundle mainBundle]
							  pathsForResourcesOfType:@"jpg" inDirectory:nil] mutableCopy];
	for (NSString __strong *filename in paths)
	{
        filename = [filename lastPathComponent];
        if(![filename hasSuffix:@"_thumb.jpg"]) {
            NSLog(@" %@", filename);
            [filenames addObject:filename];
        }
        
	}
	
	[self resetQuiz];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    adView.hidden = FALSE;
    NSLog(@"Has as showing");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    adView.hidden = TRUE;
    NSLog(@"No ad");
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(_55wcmFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}


- (void)loadNextFish
{
	NSString *nextImageName = [FishQuiz lastObject];
	[FishQuiz removeLastObject];
	correctAnswer = nextImageName;
    
	UIImage *nextImage = [UIImage imageNamed:nextImageName];
	UIImageView *nextImageView = [[UIImageView alloc] initWithImage:nextImage];
	
	[nextImageView setFrame:[fishView frame]];
	[fishView removeFromSuperview];
	fishView = nextImageView;
	[self.view addSubview:fishView];
	
   
    int offset = (int)BAR_OFFSET + 40 * (int)bars.count;
    
	NSLog(@"%i", offset);
	for (int i = (int)bars.count; i < guessRows; i++) {
		UISegmentedControl *bar = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObjects:@"", @"", nil]];
		bar.segmentedControlStyle = UISegmentedControlStyleBar;
		bar.momentary = YES;
		
		[bar addTarget:self action:@selector(submitGuess:) forControlEvents:UIControlEventValueChanged];
		CGRect frame = bar.frame;
        
        if([[UIDevice currentDevice].model hasPrefix:@"iPhone"]){
            frame.origin.y = offset;
        } else {
            frame.origin.y = offset * 2;
        }
		frame.origin.x = 20;
		NSLog(@"%@", NSStringFromCGRect( frame));
		frame.size.width = self.view.frame.size.width - 40;
		bar.frame = frame;
		[self.view addSubview:bar];
		[bars addObject:bar];
		offset += 40;
	}
	
	for (int i = (int)bars.count; i > guessRows; i--) {
		UISegmentedControl *bar = [bars lastObject];
		[bar removeFromSuperview];
		[bars removeLastObject];
	}
	
	for (UISegmentedControl *bar in bars) {
		bar.enabled = YES;
		
		for (int i = 0; i < 2; i++) {
			[bar setEnabled:YES forSegmentAtIndex:i];
		}
	}
	
	for (int i = 0; i < filenames.count; i++) {
		int n = (random() % ((int)filenames.count - i)) + i;
		
		[filenames exchangeObjectAtIndex:i withObjectAtIndex:n];
	}
	
	int correct = (int)[filenames indexOfObject:correctAnswer];
	
	[filenames exchangeObjectAtIndex:filenames.count - 1 withObjectAtIndex:correct];
	
	int fishIndex = 0;
	
	for (int i = 0; i < guessRows; i++) {
		UISegmentedControl *bar = (UISegmentedControl *)[bars objectAtIndex:i];
		int segmentIndex = 0;
		
		while (segmentIndex < 2) {
			NSString *name;
			
			if (fishIndex < filenames.count) {
				name = [filenames objectAtIndex:fishIndex];
			}
			else
				name = nil;
			
			NSString *water = [[name componentsSeparatedByString:@"-"] objectAtIndex:0];
			
			if ([[waters valueForKey:water] boolValue]) {
				[bar setTitle:[name convertToDisplayName] forSegmentAtIndex:segmentIndex];
				++segmentIndex;
			}
			
			++fishIndex;
		}
	}
	
	int n = random() % guessRows;
	UISegmentedControl *bar = [bars objectAtIndex:n];
    [[UISegmentedControl appearance] setTintColor:[UIColor blackColor]];
    
    // The attributes dictionary can specify the font, text color, text shadow color, and text
    // shadow offset for the title in the text attributes dictionary
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
	[bar setTitle:[correctAnswer convertToDisplayName] forSegmentAtIndex:random() % 2];
	
	[numberCorrectLabel setText:[NSString stringWithFormat: @"Question %i of 10", numCorrect + 1]];
	[answerLabel setText:nil];
}

- (IBAction)submitGuess:sender {
	int index = (int)[sender selectedSegmentIndex];
	
	NSString *guess = [sender titleForSegmentAtIndex:index];
	++totalGuesses;
	
	if ([guess isEqualToString:[correctAnswer convertToDisplayName]])
	{
        NSLog(@"Correct");
		answerLabel.textColor = [UIColor greenColor];
		answerLabel.text = @"Correct!";
		
		NSString *correct = [correctAnswer convertToDisplayName];
		
		for (UISegmentedControl *bar in bars)
		{
			bar.enabled = NO;
			
			for (int i = 0; i < 2; i++)
			{
				NSString *title = [bar titleForSegmentAtIndex:i];
				
				if (![title isEqualToString:correct])
					[bar setEnabled:NO forSegmentAtIndex:i];
			}
		}
		
		++numCorrect;
		
		if (numCorrect == 10)
		{
			NSString *message = [NSString stringWithFormat: @"%i guesses, %.02f%% correct", totalGuesses, 1000 / (float)totalGuesses];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Results" message:message delegate:self cancelButtonTitle: @"Reset Quiz" otherButtonTitles:nil];
			[alert show];
		}
		else
		{
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(loadNextFish) userInfo:nil repeats:NO];
			//[self performSelector:@selector(loadNextFish) withObject:nil];
		}
	}
	else
	{
		answerLabel.textColor = [UIColor redColor];
		answerLabel.text = @"Incorrect";
		
		[sender setEnabled:NO forSegmentAtIndex:index];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[self resetQuiz];
}

- (void)setGuessRows:(int)rows
{
	guessRows = rows;
}

- (void)resetQuiz
{
	numCorrect = 0;
	totalGuesses = 0;
	int i = 1;
    
	while (i <= 10)
	{
		int n = random() % (int)filenames.count;
		
		NSString *filename = [filenames objectAtIndex:n];
		NSArray *components = [filename componentsSeparatedByString:@"-"];
		NSString *water = [components objectAtIndex:0];
		NSNumber *waterEnabled = [waters valueForKey:water];
		
		if ([waterEnabled boolValue] && ![FishQuiz containsObject:filename])
		{
			[FishQuiz addObject:filename];
			++i;
		}
	}
	
	[self loadNextFish];
}

- (NSMutableDictionary *)waters
{
	return waters;
}


@end

@implementation NSString (displayName)
- (NSString *)convertToDisplayName
{
	NSString *name = [[self componentsSeparatedByString:@"-"] objectAtIndex:1];
	NSMutableString *displayName = [name mutableCopy];
	
	[displayName replaceOccurrencesOfString:@".jpg" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, displayName.length)];
	
	[displayName replaceOccurrencesOfString:@"_" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, displayName.length)];
	
	return displayName;
}


@end
