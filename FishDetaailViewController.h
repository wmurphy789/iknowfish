//
//  FishDetaailViewController.h
//  yyyy
//
//  Created by william murphy on 1/9/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fish.h"
#import "iAd/iAd.h"


@interface FishDetaailViewController : UIViewController {
    ADBannerView *adView;

}

@property(unsafe_unretained) IBOutlet UILabel *fnameLabel;
@property(unsafe_unretained) IBOutlet UILabel *locLabel;
@property(unsafe_unretained) IBOutlet UILabel *desLabel;
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

@property(strong) Fish *fish;

@end
