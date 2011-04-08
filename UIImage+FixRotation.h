//
//  UIImage+FixRotation.h
//
//  Created by Cory on 11/04/08.
//  Copyright 2011 Cory R. Leach. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (FixRotation)

//Fix the rotation of an image in place
//So UIImageView doesn't rotate it automatically
- (UIImage*) imageWithFixedRotation;

@end
