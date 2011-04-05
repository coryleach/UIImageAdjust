//
//  UIImage+Gaussian.h
//
//  Created by Cory on 11/04/05.
//  Copyright 2011 Cory R. Leach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gaussian)

- (UIImage*) imageWith3x3GaussianBlur;
- (UIImage*) imageWith5x5GaussianBlur;

@end
