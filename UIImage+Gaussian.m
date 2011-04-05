//
//  UIImage+Gaussian.m
//
//  Created by Cory on 11/04/05.
//  Copyright 2011 Cory R. Leach. All rights reserved.
//

#import "UIImage+Gaussian.h"

@implementation UIImage (Gaussian)


- (UIImage*) imageWith3x3GaussianBlur {
    
    const CGFloat filter[3][3] = { 
        {1.0f/16.0f, 2.0f/16.0f, 1.0f/16.0f},
        {2.0f/16.0f, 4.0f/16.0f, 2.0f/16.0f},
        {1.0f/16.0f, 2.0f/16.0f, 1.0f/16.0f}
    };
    
    CGImageRef imgRef = [self CGImage];
    
    size_t width = CGImageGetWidth(imgRef);
    size_t height = CGImageGetHeight(imgRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * width;
    size_t totalBytes = bytesPerRow * height;
    
    //Allocate Image space
    uint8_t* rawData = malloc(totalBytes);
    
    //Create Bitmap of same size
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //Draw our image to the context
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    
    for ( int y = 0; y < height; y++ ) {

        for ( int x = 0; x < width; x++ ) {
            
            uint8_t* pixel = rawData + (bytesPerRow * y) + (x * bytesPerPixel);
            
            CGFloat sumRed = 0;
            CGFloat sumGreen = 0;
            CGFloat sumBlue = 0;
            
            for ( int j = 0; j < 3; j++ ) {
                
                for ( int i = 0; i < 3; i++ ) {
                
                    if ( (y + j - 1) >= height || (y + j - 1) < 0 ) {
                        //Use zero values at edge of image
                        continue;
                    }
                    
                    if ( (x + i - 1) >= width || (x + i - 1) < 0 ) {
                        //Use Zero values at edge of image
                        continue;
                    }
                    
                    uint8_t* kernelPixel = rawData + (bytesPerRow * (y + j - 1)) + ((x + i - 1) * bytesPerPixel);
                    
                    sumRed += kernelPixel[0] * filter[j][i];
                    sumGreen += kernelPixel[1] * filter[j][i];
                    sumBlue += kernelPixel[2] * filter[j][i];
                    
                }
                
            }
            
            pixel[0] = roundf(sumRed);
            pixel[1] = roundf(sumGreen);
            pixel[2] = roundf(sumBlue);
            
        }
        
    }
    
    
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

- (UIImage*) imageWith5x5GaussianBlur {
    
    const CGFloat filter[5][5] = { 
        {1.0f/256.0f, 4.0f/256.0f, 6.0f/256.0f, 4.0f/256.0f, 1.0f/256.f},
        {4.0f/256.0f, 16.0f/256.0f, 24.0f/256.0f, 16.0f/256.0f, 4.0f/256.f},
        {6.0f/256.0f, 24.0f/256.0f, 36.0f/256.0f, 24.0f/256.0f, 6.0f/256.f},
        {4.0f/256.0f, 16.0f/256.0f, 24.0f/256.0f, 16.0f/256.0f, 4.0f/256.f},
        {1.0f/256.0f, 4.0f/256.0f, 6.0f/256.0f, 4.0f/256.0f, 1.0f/256.f}
    };
    
    CGImageRef imgRef = [self CGImage];
    
    size_t width = CGImageGetWidth(imgRef);
    size_t height = CGImageGetHeight(imgRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * width;
    size_t totalBytes = bytesPerRow * height;
    
    //Allocate Image space
    uint8_t* rawData = malloc(totalBytes);
    
    //Create Bitmap of same size
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //Draw our image to the context
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    
    for ( int y = 0; y < height; y++ ) {
        
        for ( int x = 0; x < width; x++ ) {
            
            uint8_t* pixel = rawData + (bytesPerRow * y) + (x * bytesPerPixel);
            
            CGFloat sumRed = 0;
            CGFloat sumGreen = 0;
            CGFloat sumBlue = 0;
            
            for ( int j = 0; j < 5; j++ ) {
                
                for ( int i = 0; i < 5; i++ ) {
                    
                    if ( (y + j - 2) >= height || (y + j - 2) < 0 ) {
                        //Use zero values at edge of image
                        continue;
                    }
                    
                    if ( (x + i - 2) >= width || (x + i - 2) < 0 ) {
                        //Use Zero values at edge of image
                        continue;
                    }
                    
                    uint8_t* kernelPixel = rawData + (bytesPerRow * (y + j - 2)) + ((x + i - 2) * bytesPerPixel);
                    
                    sumRed += kernelPixel[0] * filter[j][i];
                    sumGreen += kernelPixel[1] * filter[j][i];
                    sumBlue += kernelPixel[2] * filter[j][i];
                    
                }
                
            }
            
            pixel[0] = roundf(sumRed);
            pixel[1] = roundf(sumGreen);
            pixel[2] = roundf(sumBlue);
            
        }
        
    }
    
    
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
