//
//  OpencvWrapper.h
//  OpenCVGraficos
//
//  Created by Máster Móviles on 04/12/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

// Need this ifdef, so the C++ header won't confuse Swift
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#import <opencv2/highgui/cap_ios.h>
#endif

@interface OpencvWrapper : NSObject

+(UIImage *) grayScaleImage: (UIImage *)Image;
+(UIImage *) blurImage: (UIImage *)image;
+ (void) setCannyPart: (float) par;
+(UIImage *) canyImage: (UIImage *)image;
+(UIImage *) faceDetector: (UIImage *)image;

@end
