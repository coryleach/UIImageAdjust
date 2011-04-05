//
//  UIImage+Contrast.h
//
//  Created by Cory Leach on 3/14/11.
//  Copyright 2011 Cory R. Leach. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Contrast)
    
- (UIImage*) imageWithContrast:(CGFloat)contrastFactor;
- (UIImage*) imageWithContrast:(CGFloat)contrastFactor brightness:(CGFloat)brightnessFactor;

@end
