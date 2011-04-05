//
//  UIImage+AutoLevels.m
//
//  Created by Cory Leach on 3/11/11.
//  Copyright 2011 Cory R Leach. All rights reserved.
//

#import "UIImage+AutoLevels.h"

void CalculateAutocorretionValues(CGImageRef image, CGFloat *whitePoint, CGFloat *blackPoint);

@implementation UIImage (AutoLevels)

- (UIImage*) imageWithAutoLevels {
    
    CGFloat whitePoint;
    CGFloat blackPoint;
    
    CalculateAutocorretionValues(self.CGImage, &whitePoint, &blackPoint);
    
    const CGFloat decode[6] = {blackPoint,whitePoint,blackPoint,whitePoint,blackPoint,whitePoint};
    
    CGImageRef decodedImage;
    
    decodedImage = CGImageCreate(CGImageGetWidth(self.CGImage),
                                 CGImageGetHeight(self.CGImage),
                                 CGImageGetBitsPerComponent(self.CGImage),
                                 CGImageGetBitsPerPixel(self.CGImage),
                                 CGImageGetBytesPerRow(self.CGImage),
                                 CGImageGetColorSpace(self.CGImage),
                                 CGImageGetBitmapInfo(self.CGImage),
                                 CGImageGetDataProvider(self.CGImage),
                                 decode,
                                 YES,
                                 CGImageGetRenderingIntent(self.CGImage)
                                 );
    
    UIImage* newImage = [UIImage imageWithCGImage:decodedImage];
    
    CGImageRelease(decodedImage);
    
    return newImage;

}

@end

void CalculateAutocorretionValues(CGImageRef image, CGFloat *whitePoint, CGFloat *blackPoint) {
    
    UInt8* imageData = malloc(100 * 100 * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(imageData, 100, 100, 8, 4 * 100, colorSpace, kCGImageAlphaNoneSkipLast);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image);
    
    int histogramm[256];
    bzero(histogramm, 256 * sizeof(int));
    
    for (int i = 0; i < 100 * 100 * 4; i += 4) {
        UInt8 value = (imageData[i] + imageData[i+1] + imageData[i+2]) / 3;
        histogramm[value]++;
    }
    
    CGContextRelease(ctx);
    free(imageData);
    
    int black = 0;
    int counter = 0;
    
    // count up to 200 (2%) values from the black side of the histogramm to find the black point
    while ((counter < 200) && (black < 256)) {
        counter += histogramm[black];
        black ++;
    }
    
    int white = 255;
    counter = 0;
    
    // count up to 200 (2%) values from the white side of the histogramm to find the white point
    while ((counter < 200) && (white > 0)) {
        counter += histogramm[white];
        white --;
    }
    
    *blackPoint = 0.0 - (black / 256.0);
    *whitePoint = 1.0 + ((255-white) / 256.0);
    
}

