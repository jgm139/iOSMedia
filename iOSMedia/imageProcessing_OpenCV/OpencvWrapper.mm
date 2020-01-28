//
//  OpencvWrapper.m
//  OpenCVGraficos
//
//  Created by Máster Móviles on 04/12/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

#import "OpencvWrapper.h"

@implementation OpencvWrapper

+(UIImage *) grayScaleImage: (UIImage *)image
{
    cv::Mat imageMat;
    UIImageToMat(image,imageMat);
    
    if(imageMat.channels() == 1){ return image; }
    
    cv::Mat gray;
    // Convert the image to grayscale
    cv::cvtColor(imageMat, gray, CV_RGBA2GRAY);
    return MatToUIImage(gray);
}

+(UIImage *) blurImage: (UIImage *)image
{
     cv::Mat imageMat;
     UIImageToMat(image,imageMat);
     cv::Mat blurImage;
     cv::GaussianBlur( imageMat, blurImage, cv::Size( 3, 3 ), 0, 0 );
     return MatToUIImage(blurImage);
}

float canny_par2 = 350;

+ (void) setCannyPart: (float) par
{
    canny_par2 = par;
}

+(UIImage *) canyImage: (UIImage *)image
{
    cv::Mat imageMat;
    UIImageToMat(image,imageMat);
    cv::Mat contours;
    cv::Mat gray;
    cv::cvtColor(imageMat, gray, CV_RGBA2GRAY);
    cv::Canny(gray, contours, 10, canny_par2);
    
    return MatToUIImage(contours);
}

+(UIImage *) faceDetector: (UIImage *)image
{
    cv::CascadeClassifier faceDetector;
    NSString* cascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2" ofType:@"xml"];
    
    faceDetector.load([cascadePath UTF8String]);
    
    cv::Mat imageMat;
    UIImageToMat(image,imageMat);
    cv::Mat cannyImage;
    cv::Mat contours;
    cv::Mat gray;
    cv::cvtColor(imageMat, gray, CV_RGBA2GRAY);
    
    // Detect faces
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));

    // Draw all detected faces
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(imageMat, tl, br, magenta, 4, 8, 0);
    }
    
    return MatToUIImage(imageMat);
}

@end

