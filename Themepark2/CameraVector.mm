//
//  CameraVector.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraVector.h"

@implementation CameraVector
@synthesize x,y,z;



- (CameraVector*) init{
    GLdouble defaultX=0;
    GLdouble defaultY=0;
    GLdouble defaultZ=0;
    return [self initWithX:defaultX setY:defaultY setZ:defaultZ];
}

- (CameraVector*) initWithX: (GLdouble) xInput setY: (GLdouble) yInput setZ: (GLdouble) zInput{
    if (self=[super init]){
        [self setX:xInput setY:yInput setZ:zInput];
    }
    return self;
}


- (void) addVector: (CameraVector*) vector{
    x+=[vector x];
    y+=[vector y];
    z+=[vector z];
}




- (void) setX: (GLdouble) xInput setY: (GLdouble) yInput setZ: (GLdouble) zInput{
    x=xInput;
    y=yInput;
    z=zInput;
}


- (void) normalize{
    GLdouble total =sqrt(x*x+y*y+z*z);
    if (total==0) {
        total=1;
    }
    x= x/ total;
    y= y/ total;
    z= z/ total;
}

- (CameraVector*) scale: (float) scale{
    GLdouble scaledX=x*scale;
    GLdouble scaledY=y*scale;
    GLdouble scaledZ=z*scale;
    return [[CameraVector alloc] initWithX:scaledX setY:scaledY setZ:scaledZ];
}


- (NSString *) description{
    return [NSString stringWithFormat:
            @"x: %f y: %f z: %f", x,y,z];
}




@end
