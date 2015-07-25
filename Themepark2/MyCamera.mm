//
//  MyCamera.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyCamera.h"

@implementation MyCamera
@synthesize viewPosition, viewDirection, aperature, viewWidth, viewHeight;

- (MyCamera*) init{
    if (self=[super init]) {
        viewPosition = [[CameraVector alloc] initWithX:40 setY:40 setZ:30];
        viewDirection = [[CameraVector alloc] init];
        viewLeft = [[CameraVector alloc] init];
        aperture = 45;
        viewWidth = 100;
        viewHeight = 100;
        cameraMoveSpeed = 20;
        cameraRotationSpeed = 50;
        theta = -30;
        phi =225;
        [self updateViewDirectionToThetaAndPhi];
    }
    return self;
}

- (void) strafe: (float) distance{
    [viewPosition addVector:[viewLeft scale:distance]];
}

- (void) dolly: (float) distance{
    [viewPosition addVector:[viewDirection scale:distance]];
}

- (void) rise: (float) distance{
    GLdouble newHeight= [viewPosition z]+distance;    
    [viewPosition setZ: newHeight];
}

- (void) panHorzontal: (float) x vertical: (float) y{
    float thetaChange, phiChange;
    
    thetaChange=y;
    
    theta+=thetaChange;
    if (theta>.9*90) {
        theta=.9*90;
    }
    if (theta<-.9*90) {
        theta=(-(.9*90));
    }
    
    phiChange=x*1/cosf(theta/180*M_PI);

//    phiChange=x;
    phi+=phiChange;
    
    while (phi>360) {
        phi-=360;
    }
    
    while (phi<0) {
        phi+=360;
    }
    
    [self updateViewDirectionToThetaAndPhi];
}


- (void) updateViewDirectionToThetaAndPhi{
    [viewDirection setZ:sinf(theta/180*M_PI)];
    [viewDirection setX:cosf(phi/180*M_PI)*cosf(theta/180*M_PI)];
    [viewDirection setY:sinf(phi/180*M_PI)*cosf(theta/180*M_PI)];
    [viewDirection normalize]; //also probably not needed
    
    [viewLeft setX:cosf(phi/180*M_PI-M_PI/2)];
    [viewLeft setY:sinf(phi/180*M_PI-M_PI/2)];
    [viewLeft setZ:0];
    [viewLeft normalize]; // Probably unneeded.... 
//    NSLog(@"%@",self);
}


- (NSString *) description{
    return [NSString stringWithFormat:
            @"\nTheta %f Phi %f\nView Position %@\nView Direction: %@\nView Left: %@",theta,phi, viewPosition, viewDirection, viewLeft];
}


- (void) strafeLeftForDuration: (CFAbsoluteTime) deltaTime{
    [self strafe:-deltaTime*cameraMoveSpeed];
}


- (void) strafeRightForDuration: (CFAbsoluteTime) deltaTime{
    [self strafe:+deltaTime*cameraMoveSpeed];
}

- (void) moveForwardForDuration: (CFAbsoluteTime) deltaTime{
    [self dolly:deltaTime*cameraMoveSpeed];
}

- (void) moveBackwardForDuration: (CFAbsoluteTime) deltaTime{
    [self dolly:-deltaTime*cameraMoveSpeed];
}
- (void) moveUpForDuration: (CFAbsoluteTime) deltaTime{
    [self rise:cameraMoveSpeed*deltaTime];
}
- (void) moveDownForDuration: (CFAbsoluteTime) deltaTime{
    [self rise:-cameraMoveSpeed*deltaTime];
}

- (void) panLeftForDuration: (CFAbsoluteTime) deltaTime{
    [self panHorzontal:deltaTime*cameraRotationSpeed vertical:0];
}
- (void) panRightForDuration: (CFAbsoluteTime) deltaTime{
    [self panHorzontal:-deltaTime*cameraRotationSpeed vertical:0];
}
- (void) panUpForDuration: (CFAbsoluteTime) deltaTime{
    [self panHorzontal:0 vertical:deltaTime*cameraRotationSpeed];
}

- (void) panDownForDuration: (CFAbsoluteTime) deltaTime{
    [self panHorzontal:0 vertical:-deltaTime*cameraRotationSpeed];
}

- (void) setPositionX: (float) positionXInput 
            positionY: (float) positionYInput 
            positionZ: (float) positionZInput 
           directionX: (float) directionXInput 
           directionY: (float) directionYInput 
           directionZ: (float) directionZInput{
    [[self viewPosition] setX:positionXInput setY:positionYInput setZ:positionZInput];
    [[self viewDirection] setX:directionXInput setY:directionYInput setZ:directionZInput];
    [[self viewDirection] normalize];
//    
//    theta = acosf([[self viewDirection] z]);
//        NSLog(@"%f",theta);
//    
//    
//    
//    theta-=90;
//    
//    
//    
//    if (theta>.9*90) {
//        theta=.9*90;
//    }
//    if (theta<-.9*90) {
//        theta=(-(.9*90));
//    }
//    
//
//    phi = 180*atan2([[self viewDirection] y], [[self viewDirection] x]);
//    [self updateViewDirectionToThetaAndPhi];
}









@end
