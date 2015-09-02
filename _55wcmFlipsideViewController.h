//
//  _55wcmFlipsideViewController.h
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/iAd.h"

@class _55wcmFlipsideViewController;

@protocol _55wcmFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(_55wcmFlipsideViewController *)controller;
@end

@interface _55wcmFlipsideViewController : UIViewController {
    __weak id <_55wcmFlipsideViewControllerDelegate> delegate;
    IBOutlet UISegmentedControl *choicesControl;
    IBOutlet UISwitch *lakesSwitch;
    IBOutlet UISwitch *riversSwitch;
    IBOutlet UISwitch *oceansSwitch;
    ADBannerView *adView;

}

@property (weak, nonatomic) id <_55wcmFlipsideViewControllerDelegate> delegate;
@property(nonatomic, retain) IBOutlet UISegmentedControl *choicesControl;
@property(nonatomic, retain) IBOutlet UISwitch *lakesSwitch;
@property(nonatomic, retain) IBOutlet UISwitch *riversSwitch;
@property(nonatomic, retain) IBOutlet UISwitch *oceansSwitch;
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

- (IBAction)done:(id)sender;
- (void)setSwitches:(NSDictionary *)dictionary;
- (void)setSelectedIndex:(int)index;
@end
