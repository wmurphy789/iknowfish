//
//  fishTable.h
//  yyyy
//
//  Created by william murphy on 1/8/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fish.h"
#import "iAd/iAd.h"

@interface fishTable : UITableViewController {
    NSMutableArray *myArray;
    NSMutableArray *lake;
    NSMutableArray *ocean;
    NSInteger count;
    ADBannerView *adView;

}
@property(nonatomic, retain) IBOutlet ADBannerView *adView;

@end
