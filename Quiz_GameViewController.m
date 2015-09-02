//
//  Quiz_GameViewController.m
//  yyyy
//
//  Created by william murphy on 1/13/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "Quiz_GameViewController.h"

@interface Quiz_GameViewController ()

@end

@implementation Quiz_GameViewController

@synthesize theQuestion, theScore, theLives, answerOne, answerTwo, answerThree, answerFour, theQuiz;
@synthesize adView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    NSLog(@"ViewDid");
    [super viewDidLoad];
	questionLive = NO;
	restartGame = NO;
	theQuestion.text = @"Think you can do it?";
	theScore.text = @"Score: 0";
	theLives.text = @"";
	questionNumber = 0;
	myScore = 0;
	myLives = 0;
	[answerOne setTitle:@"I think i can!" forState:UIControlStateNormal];
	[answerTwo setHidden:YES];
	[answerThree setHidden:YES];
	[answerFour setHidden:YES];
    
	[self loadQuiz];
}

-(void)loadQuiz
{
    NSLog(@"loadQuiz");
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *textFilePath = [bundle pathForResource:@"quizgame" ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:nil];
	[NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:nil];
    quizArray = [[NSArray alloc] initWithArray:[fileContents componentsSeparatedByString:@"\n"]];
    self.theQuiz = quizArray;
    //[quizArray release];
    
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    adView.hidden = FALSE;
    NSLog(@"Has as showing");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    adView.hidden = TRUE;
    NSLog(@"No ad");
}

-(void)askQuestion
{
    NSLog(@"ask");
	// Unhide all the answer buttons.
	[answerOne setHidden:NO];
	[answerTwo setHidden:NO];
	[answerThree setHidden:NO];
	[answerFour setHidden:NO];
	
	// Set the game to a \"live\" question (for timer purposes)
	questionLive = YES;
	
	// Set the time for the timer
	//time = 10.0;
	
	// Go to the next question
    
    NSInteger row = 0;
    
    if(questionNumber == 0) {
    
        arryRandomNumber=[[NSMutableArray alloc]init];
        while (arryRandomNumber.count<10) {
            NSInteger randomNumber=1+arc4random()%75;
            if (![arryRandomNumber containsObject:[NSString stringWithFormat:@"%ld",(long)randomNumber]]){
                [arryRandomNumber addObject:[NSString stringWithFormat:@"%ld",(long)randomNumber]];
            }
        }
        NSLog(@"%@",arryRandomNumber);
    }
         j = [[arryRandomNumber objectAtIndex:x]intValue];
        questionNumber = j + 1;
		
		if(questionNumber == 1) {
			row = questionNumber - 1;
		}
		else {
			row = ((questionNumber - 1) * 6);
		}
        answerCount++;
        x++;
    
	// Set the question string, and set the buttons the the answers
	NSString *selected = [theQuiz objectAtIndex:row];
	NSString * const activeQuestion = [[NSString alloc] initWithFormat:@"%@", selected];
                                [answerOne setTitle:[theQuiz objectAtIndex:row+1] forState:UIControlStateNormal];
                                [answerTwo setTitle:[theQuiz objectAtIndex:row+2] forState:UIControlStateNormal];
                                [answerThree setTitle:[theQuiz objectAtIndex:row+3] forState:UIControlStateNormal];
                                [answerFour setTitle:[theQuiz objectAtIndex:row+4] forState:UIControlStateNormal];
                                rightAnswer = [[theQuiz objectAtIndex:row+5] intValue];
                                
                                // Set theQuestion label to the active question
                                theQuestion.text = activeQuestion;
   
	//[selected release];
	//[activeQuestion release];
}

-(void)updateScore
{
	questionLive = NO;
	
	[answerOne setHidden:YES];
	[answerTwo setHidden:YES];
	[answerThree setHidden:YES];
	[answerFour setHidden:YES];
	NSString *scoreUpdate = [[NSString alloc] initWithFormat:@"Score: %ld", (long)myScore];
	theScore.text = scoreUpdate;
	
	// END THE GAME.
	if(answerCount == 10)
	{
		// Game is over.
		if(myScore > 0)
		{
			NSString *finishingStatement = [[NSString alloc] initWithFormat:@"Game Over! Nice Job! You scored %li!", (long)myScore];
			theQuestion.text = finishingStatement;
		}
		else
		{
			NSString *finishingStatement = [[NSString alloc] initWithFormat:@"Game Over! Better Luck Next Time! You scored %li.", (long)myScore];
			theQuestion.text = finishingStatement;
		}
		theLives.text = @"";
		
		// Make button 1 appear as a reset game button
		restartGame = YES;
		[answerOne setHidden:NO];
        //[answerOne addTarget:self action:@selector(reset)forControlEvents:UIControlEventTouchDown];
		[answerOne setTitle:@"Restart game!" forState:UIControlStateNormal];
		answerCount = 0;
        x = 0;
        j = 0;
	}
	else {
        [self askQuestion];
	}
}

- (IBAction)buttonOne
{
	if(questionNumber == 0) {
		[answerTwo setHidden:NO];
		[answerThree setHidden:NO];
		[answerFour setHidden:NO];
		[self askQuestion];
	}
	else {
        if(restartGame == YES) {
			// Create a restart game function.
            [answerOne setTitle:@"Lets do this again!" forState:UIControlStateNormal];
            answerCount = 0;
            [self reset];
		} else {
            [self checkAnswer:1];
        }
	}
}

- (IBAction)buttonTwo {
	[self checkAnswer:2];
}

- (IBAction)buttonThree {
	[self checkAnswer:3];
}

- (IBAction)buttonFour {
	[self checkAnswer:4];
}

// Check for the answer (this is not written right, but it runs)
-(void)checkAnswer:(int)theAnswerValue
{
	if(rightAnswer == theAnswerValue) {
		theQuestion.text = @"That is correct!";
		myScore = myScore + 50;
	}
	else {
		theQuestion.text = @"Better Luck Next Time";
		myScore = myScore - 50;
	}
	[self updateScore];
}


-(void)reset {
    NSLog(@"Reset");
    //[answerOne removeTarget:self action:@selector(reset)forControlEvents:UIControlEventTouchDown];
    questionLive = NO;
	restartGame = NO;
	theScore.text = @"Score: 0";
	theLives.text = @"";
    x = 0;
    j = 0;
	questionNumber = 0;
	myScore = 0;
	myLives = 0;
    answerCount = 0;
    [self loadQuiz];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

@end
