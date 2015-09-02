//
//  mainView.h
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/iAd.h"

@interface mainView : UIViewController {
    ADBannerView *adView;

}
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

@end
