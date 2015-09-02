//
//  _55wcmMainViewController.h
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "_55wcmFlipsideViewController.h"
#import "iAd/iAd.h"

@interface _55wcmMainViewController : UIViewController <_55wcmFlipsideViewControllerDelegate, UIPopoverControllerDelegate> {
    ADBannerView *adView;

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

@end
