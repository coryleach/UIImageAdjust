//
//  UIImage+Thumbnail.m
//  Shiseido
//
//  Created by Cory on 11/04/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Thumbnail.h"


@implementation UIImage (Thumbnail)

- (UIImage*) imageWithThumbnailWidth:(CGFloat)thumbnailWidth {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    //Get thumbnail scale
    CGFloat scale = thumbnailWidth/width;
    
    //Find dimensions of thumbnail with const aspect ratio
    width = thumbnailWidth;
    height = self.size.height*scale;
        
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * width;
    size_t totalBytes = bytesPerRow * height;
    
    //Allocate Image space
    uint8_t* rawData = malloc(totalBytes);
    
    //Create Bitmap of same size
    CGContextRef context = CGBitmapContextCreate(rawData,width,height,bitsPerComponent,bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //Draw our image to the context
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);

    //Create Image
    CGImageRef newImg = CGBitmapContextCreateImage(context);
    
    //Release Created Data Structs
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(rawData);
    
    //Create UIImage struct around image
    UIImage* image = [UIImage imageWithCGImage:newImg];
    
    //Release our hold on the image
    CGImageRelease(newImg);
    
    //return new image!
    return image;
    
}

@end
