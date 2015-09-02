//
//  photoGame.h
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_55wcmFlipsideViewController.h"
#import "iAd/iAd.h"


@interface photoGame : UIViewController<_55wcmFlipsideViewControllerDelegate, UIPopoverControllerDelegate> {
    IBOutlet UIImageView *fishView;
    IBOutlet UILabel *answerLabel;
    IBOutlet UILabel *numberCorrectLabel;
    NSMutableArray *bars;
    NSMutableArray *filenames;
    NSMutableArray *FishQuiz;
    NSMutableDictionary *waters;
    NSString *correctAnswer;
    int totalGuesses;
    int numCorrect;
    int guessRows;
    ADBannerView *adView;

}

// property declartions
@property (nonatomic, retain) IBOutlet UIImageView *fishView;
@property (nonatomic, retain) IBOutlet UILabel *answerLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberCorrectLabel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

// method declarations

- (IBAction)submitGuess:sender;
- (void)loadNextFish;
- (void)setGuessRows:(int)rows;
- (void)resetQuiz;
- (NSMutableDictionary *)waters;
@end

@interface NSString (displayName)
- (NSString *)convertToDisplayName;
@end
