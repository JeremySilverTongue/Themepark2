//
//  MyTrainCar.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTrainCar.h"

@implementation MyTrainCar
- (id) init{
    distanceBetweenCars = .01;
    
    
    self = [super init];
    
    
    
    
    
    initialized = false;
    


    
    
    return self;
}






- (bool) initialize{
    car_list = glGenLists(1);
    glNewList(car_list, GL_COMPILE);
    glColor3f(1.0, 0.0, 0.0);
    glBegin(GL_QUADS);
	glNormal3f(0.0f, 0.0f, 1.0f);
	glVertex3f(0.5f, 0.5f, 1.0f);
	glVertex3f(-0.5f, 0.5f, 1.0f);
	glVertex3f(-0.5f, -0.5f, 1.0f);
	glVertex3f(0.5f, -0.5f, 1.0f);
    
	glNormal3f(0.0f, 0.0f, -1.0f);
	glVertex3f(0.5f, -0.5f, 0.0f);
	glVertex3f(-0.5f, -0.5f, 0.0f);
	glVertex3f(-0.5f, 0.5f, 0.0f);
	glVertex3f(0.5f, 0.5f, 0.0f);
    
    
	glNormal3f(1.0f, 0.0f, 0.0f);
	glVertex3f(0.5f, 0.5f, 0.0f);
	glVertex3f(0.5f, 0.5f, 1.0f);
	glVertex3f(0.5f, -0.5f, 1.0f);
	glVertex3f(0.5f, -0.5f, 0.0f);
    
	glNormal3f(-1.0f, 0.0f, 0.0f);
	glVertex3f(-0.5f, 0.5f, 1.0f);
	glVertex3f(-0.5f, 0.5f, 0.0f);
	glVertex3f(-0.5f, -0.5f, 0.0f);
	glVertex3f(-0.5f, -0.5f, 1.0f);
    
	glNormal3f(0.0f, 1.0f, 0.0f);
	glVertex3f(0.5f, 0.5f, 1.0f);
	glVertex3f(0.5f, 0.5f, 0.0f);
	glVertex3f(-0.5f, 0.5f, 0.0f);
	glVertex3f(-0.5f, 0.5f, 1.0f);
    
	glNormal3f(0.0f, -1.0f, 0.0f);
	glVertex3f(0.5f, -0.5f, 0.0f);
	glVertex3f(0.5f, -0.5f, 1.0f);
	glVertex3f(-0.5f, -0.5f, 1.0f);
	glVertex3f(-0.5f, -0.5f, 0.0f);
    glEnd();
    glEndList();

    return true;
}



- (void) draw{
    glPushMatrix();
    glCallList(car_list);
    glPopMatrix();
    }



- (void) drawOnTrack: (CubicBspline*) track atPosition: (float) position carNumber: (int) carNumber{
    
    float   posn[3];
    float   tangent[3];
    double  angle;
    
    

    
    
    float   deriv[3];
    double  length;
    double  parametric_speed;
    

//    
    track->Evaluate_Derivative(position, deriv);
    length = sqrt(deriv[0]*deriv[0] + deriv[1]*deriv[1] + deriv[2]*deriv[2]);
//    if ( length == 0.0 )
//        return;
    
    float positionOfThisCar= position - carNumber*distanceBetweenCars*length;
    
    
    if ( positionOfThisCar > track->N() )
        positionOfThisCar -= track->N();
    if (positionOfThisCar<0) {
        positionOfThisCar+= track->N();
    }
//    while (positionOfThisCar<0) {
//        positionOfThisCar++;
//    }
//    
//    while (positionOfThisCar>1) {
//        positionOfThisCar--;
//    }
    
//    positionOfThisCar=positionOfThisCar-floor(positionOfThisCar);
    
    glPushMatrix();
    
    // Figure out where the train is
    track->Evaluate_Point(positionOfThisCar, posn);
    
    // Translate the train to the point
    glTranslatef(posn[0], posn[1], posn[2]);
    
    // ...and what it's orientation is
    track->Evaluate_Derivative(positionOfThisCar, tangent);
    [self Normalize_3: tangent];
    
    // Rotate it to poitn along the track, but stay horizontal
    angle = atan2(tangent[1], tangent[0]) * 180.0 / M_PI;
    glRotatef((float)angle, 0.0f, 0.0f, 1.0f);
    
    // Another rotation to get the tilt right.
    angle = asin(-tangent[2]) * 180.0 / M_PI;
    glRotatef((float)angle, 0.0f, 1.0f, 0.0f);
    
    
    
    
    
    // Draw the train
    glCallList(car_list);

    glPopMatrix();
}




- (void) dealloc{
    [super dealloc];
}






@end
