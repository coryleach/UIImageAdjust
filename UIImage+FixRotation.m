//
//  UIImage+FixRotation.m
//
//  Created by Cory on 11/04/08.
//  Copyright 2011 Cory R. Leach. All rights reserved.
//

#import "UIImage+FixRotation.h"


@implementation UIImage (FixRotation)

- (UIImage*) imageWithFixedRotation {
    
    CGImageRef imgRef = self.CGImage;  
	
    CGFloat width = CGImageGetWidth(imgRef);  
    CGFloat height = CGImageGetHeight(imgRef);  
    
    CGAffineTransform transform = CGAffineTransformIdentity;  
    CGRect bounds = CGRectMake(0, 0, width, height);  
    CGFloat boundHeight;
    
    //Check orientation
    UIImageOrientation orient = self.imageOrientation;  
    switch(orient) {  
			
        case UIImageOrientationUp:
            transform = CGAffineTransformMakeTranslation(width, height);  
            transform = CGAffineTransformRotate(transform, M_PI); //*/
            break; //No rotation to fix
		
        
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(width, 0.0);  
            transform = CGAffineTransformScale(transform, -1.0, 1.0); //*/ 
            break;  
			
        case UIImageOrientationDown:
            //transform = CGAffineTransformMakeTranslation(width, height);  
            //transform = CGAffineTransformRotate(transform, M_PI); //*/
            break;  
			
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, height);  
            transform = CGAffineTransformScale(transform, 1.0, -1.0);//*/  
            break;  
			
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeTranslation(height, width);  
            transform = CGAffineTransformScale(transform, -1.0, 1.0);  
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);//*/  
            break;  
			
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeTranslation(0.0, width);  
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);//*/  
            break;  
			
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);  
            break;  
			
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeTranslation(height, 0.0);  
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);//*/
            break;  
			
        default:  
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"]; 
			
    }  
	
    UIGraphicsBeginImageContext(bounds.size);  
	
    CGContextRef context = UIGraphicsGetCurrentContext();  
	
    CGContextConcatCTM(context, transform);  
	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);  
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();  
	
    return imageCopy;
    
} 

@end
