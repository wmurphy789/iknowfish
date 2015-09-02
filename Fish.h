//
//  Fish.h
//  yyyy
//
//  Created by william murphy on 1/9/13.
//  Copyright (c) 2013 william murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fish : NSObject
@property(strong)NSString *fname;
@property(strong)NSString *locations;
@property(strong)NSString *description;
@property(strong)UIImage *photo;
@property(strong)UIImage *thumb;

-(id)initWithFname:(NSString *)aFname locations:(NSString *)aSname description:(NSString *)aDes photo:(UIImage *)aPhoto thumb:(UIImage *)aThumb;

@end
