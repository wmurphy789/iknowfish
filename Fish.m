//
//  Fish.m
//  yyyy
//
//  Created by william murphy on 1/9/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import "Fish.h"

@implementation Fish
@synthesize fname, description, locations, photo, thumb;

-(id)initWithFname:(NSString *)aFname locations:(NSString *)aSname description:(NSString *)aDes photo:(UIImage *)aPhoto thumb:(UIImage *)aThumb{
    self = [super init];
    if(self) {
        self.fname = aFname;
        self.description = aSname;
        self.locations = aDes;
        self.photo = aPhoto;
        self.thumb = aThumb;
    }
    return self;
}

@end
