//
//  MyCamera.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGL/gl.h"
#import "OpenGL/glu.h"
#import "math.h"
#include <GLUT/glut.h>
#include "CubicBspline.h"
#include "CameraVector.h"

@interface MyCamera : NSObject {
    float theta, phi;

    CameraVector* viewPosition; // View position
    CameraVector* viewDirection; // View direction vector
    CameraVector* viewLeft;
    GLdouble aperture; // pContextInfo->camera aperture
    GLint viewWidth, viewHeight; // current window/screen height and width
    GLdouble cameraMoveSpeed, cameraRotationSpeed;
}

@property CameraVector* viewPosition;
@property CameraVector* viewDirection;
@property GLdouble aperature;
@property GLint viewWidth, viewHeight;








- (MyCamera*) init;
- (void) strafe: (float) distance;
- (void) dolly: (float) distance;
- (void) rise: (float) distance;
- (void) panHorzontal: (float) x vertical: (float) y;
- (void) updateViewDirectionToThetaAndPhi;
- (void) setPositionX: (float) positionXInput 
            positionY: (float) positionYInput 
            positionZ: (float) positionZInput 
           directionX: (float) directionXInput 
           directionY: (float) directionYInput 
           directionZ: (float) directionZInput;




- (void) strafeLeftForDuration: (CFAbsoluteTime) deltaTime;
- (void) strafeRightForDuration: (CFAbsoluteTime) deltaTime;
- (void) moveForwardForDuration: (CFAbsoluteTime) deltaTime;
- (void) moveBackwardForDuration: (CFAbsoluteTime) deltaTime;
- (void) moveUpForDuration: (CFAbsoluteTime) deltaTime;
- (void) moveDownForDuration: (CFAbsoluteTime) deltaTime;
- (void) panLeftForDuration: (CFAbsoluteTime) deltaTime;
- (void) panRightForDuration: (CFAbsoluteTime) deltaTime;
- (void) panUpForDuration: (CFAbsoluteTime) deltaTime;
- (void) panDownForDuration: (CFAbsoluteTime) deltaTime;











- (NSString *) description;


@end
