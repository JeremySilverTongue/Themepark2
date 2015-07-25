//
//  CameraVector.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraVector : NSObject {
    GLdouble x,y,z;
}
@property GLdouble x,y,z;



- (CameraVector*) init;
- (CameraVector*) initWithX: (GLdouble) xInput setY: (GLdouble) yInput setZ: (GLdouble) zInput;

- (void) addVector: (CameraVector*) vector;
- (void) setX: (GLdouble) xInput setY: (GLdouble) yInput setZ: (GLdouble) zInput;
- (void) normalize;
- (CameraVector*) scale: (float) scale;


//- (void) rotatePhi: (float) phi theta: (float) theta;

- (NSString *) description;




@end
