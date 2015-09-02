//
//  Quiz_GameViewController.h
//  yyyy
//
//  Created by william murphy on 1/13/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/iAd.h"

@interface Quiz_GameViewController : UIViewController {
    IBOutlet UILabel *theQuestion;
    IBOutlet UILabel *theScore;
    IBOutlet UILabel *theLives;
    IBOutlet UIButton *answerOne;
    IBOutlet UIButton *answerTwo;
    IBOutlet UIButton *answerThree;
    IBOutlet UIButton *answerFour;
    NSInteger myScore;
    NSInteger myLives;
    NSInteger questionNumber;
    NSInteger rightAnswer;
    //NSInteger time;
    NSArray *theQuiz;
    NSArray *quizArray;
    //NSTimer *timer;
    int answerCount;
    BOOL questionLive;
    BOOL restartGame;
    NSMutableArray *arryRandomNumber;
    int j;
    int x;
    ADBannerView *adView;
}

@property (retain, nonatomic) UILabel *theQuestion;
@property (retain, nonatomic) UILabel *theScore;
@property (retain, nonatomic) UILabel *theLives;
@property (retain, nonatomic) UIButton *answerOne;
@property (retain, nonatomic) UIButton *answerTwo;
@property (retain, nonatomic) UIButton *answerThree;
@property (retain, nonatomic) UIButton *answerFour;
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

@property (retain, nonatomic) NSArray *theQuiz;
//@property (retain, nonatomic) NSTimer *timer;

-(IBAction)buttonOne;
-(IBAction)buttonTwo;
-(IBAction)buttonThree;
-(IBAction)buttonFour;

-(void)checkAnswer:(int)theAnswerValue;
-(void)askQuestion;
-(void)updateScore;
-(void)loadQuiz;
//-(void)countDown;
-(void)reset;

@end
