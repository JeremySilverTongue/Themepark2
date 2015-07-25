//
//  MyTrack.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTrack.h"

@implementation MyTrack






- (id) init {
    self = [super init];
    initialized = false; posn_on_track = 0.0f; speed = 0.0f;
    
    cars = [[NSMutableArray alloc] initWithCapacity:8];
    for (int horseIndex=0; horseIndex<4; horseIndex++) {
        [cars addObject:[[MyTrainCar alloc] init]];
    }
    return self;
}

- (void) dealloc{
    if ( initialized )
    {
        glDeleteLists(track_list, 1);
        glDeleteLists(train_list, 1);
    }
}





- (bool) initialize{
    // track spline control points
    TRACK_NUM_CONTROLS = 4;
    // The carriage energy and mass
    TRAIN_ENERGY = 0.0f;
    
    
    
    CubicBspline    refined(3, true);
    int		    n_refined;
    float	    p[3];
    int		    i;
    
    // Create the track spline.
    track = new CubicBspline(3, true);
//    for ( i = 0 ; i < TRACK_NUM_CONTROLS ; i++ )
//        track->Append_Control(TRACK_CONTROLS[i]);

    track->Append_Control((float[3]){ 0, 0,1 });
    track->Append_Control((float[3]){ 20.0, 0, 1});
    track->Append_Control((float[3]){ 30.0, 10.0, 1 });
    track->Append_Control((float[3]){ 20.0, 20.0, 1 });
    
    track->Append_Control((float[3]){ 10.0, 20.0, 10.0 });
    track->Append_Control((float[3]){ 0.0, 20.0, 30.0 });
    track->Append_Control((float[3]){ -10.0, 20.0, 1 });
    track->Append_Control((float[3]){ -20.0, 20.0, 1 });
    track->Append_Control((float[3]){ -30.0, 20.0, 1.0 });
    track->Append_Control((float[3]){ -30.0, 00.0, 1.0 });
    track->Append_Control((float[3]){ -20.0, 00.0, 1.0 });
    track->Append_Control((float[3]){ -10.0, 00.0, 10.0 });
    
    
    // Refine it down to a fixed tolerance. This means that any point on
    // the track that is drawn will be less than 0.1 units from its true
    // location. In fact, it's even closer than that.
    track->Refine_Tolerance(refined, 0.1f);
    n_refined = refined.N();
    
    
    track_list = glGenLists(1);
    glNewList(track_list, GL_COMPILE);
	glColor3f(0.0f, 1.0, 0.0f);
	glBegin(GL_LINE_STRIP);
    for ( i = 0 ; i <= n_refined ; i++ )
    {
		refined.Evaluate_Point((float)i, p);
        
        
        
        
		glVertex3fv(p);
    }
	glEnd();
    glEndList();


    
//    float rail1[4]
//    
//    
//    track_list = glGenLists(1);
//    glNewList(track_list, GL_COMPILE);
//	glColor3f(0.0f, 1.0, 0.0f);
//    
//    float oldpoint[3],newpoint[3];
//    
//    refined.Evaluate_Point((float)i, oldpoint);
//    
//    
//    for ( i = 0 ; i <= n_refined ; i++ )
//    {
//		refined.Evaluate_Point((float)i, newpoint);
//        
//        
//        
//        
//        glBegin(GL_TRIANGLE_STRIP);
//        
//        
//        glVertex3d(<#GLdouble x#>, <#GLdouble y#>, <#GLdouble z#>)
//        
//        
//        
//        
//		glVertex3fv(p);
//        
//        glEnd();
//    }
//	
//    glEndList();
    
    
    
    
    
    
    
    for (MyTrainCar* car in cars) {
        [car initialize];
    }
    
    
    
    initialized = true;
    
    return true;
}

- (void) draw{    
    if ( ! initialized )
        return;
    glPushMatrix();
    glCallList(track_list);
    int carIndex=0;
    for (MyTrainCar* car in cars) {
        [car drawOnTrack: track atPosition: posn_on_track carNumber:carIndex];
        carIndex++;
    }
    

    
    
    glPopMatrix();
}




- (void) update: (float) dt{
    float   point[3];
    float   deriv[3];
    double  length;
    double  parametric_speed;
    
    if ( ! initialized )
        return;

    track->Evaluate_Derivative(posn_on_track, deriv);
    length = sqrt(deriv[0]*deriv[0] + deriv[1]*deriv[1] + deriv[2]*deriv[2]);
    if ( length == 0.0 )
        return;
    parametric_speed = speed / length;
    posn_on_track += (float)(parametric_speed * dt);
    if ( posn_on_track > track->N() )
        posn_on_track -= track->N();
    track->Evaluate_Point(posn_on_track, point);
    if ( TRAIN_ENERGY - 9.81 * point[2] < 1.0 ){
        TRAIN_ENERGY= 9.81 * point[2]+15;
    }
    speed = (float)sqrt(2.0 * ( TRAIN_ENERGY - 9.81 * point[2] ));
    TRAIN_ENERGY-=.05*speed*speed*dt;
}

- (void) moveCameraToChaseCar: (MyCamera*) camera{
    float   point[3];
    float   deriv[3];
    track->Evaluate_Derivative(posn_on_track, deriv);
    track->Evaluate_Point(posn_on_track, point);
    
    if (deriv[2]<0) {
        [camera setPositionX:point[0]-.5*deriv[0]
                   positionY:point[1]-.5*deriv[1]
                   positionZ:point[2]-.8*deriv[2]+2 
                  directionX:deriv[0]
                  directionY:deriv[1]
                  directionZ:deriv[2]-2
     ];
    } else {
        [camera setPositionX:point[0]-.5*deriv[0]
                   positionY:point[1]-.5*deriv[1]
                   positionZ:point[2]-.1*deriv[2]+2 
                  directionX:deriv[0]
                  directionY:deriv[1]
                  directionZ:.3*deriv[2]-2
         ];
    }
    
    
    
//    NSLog(@"%@",camera);
    
}

- (void) moveCameraToCar: (MyCamera*) camera{
    float   point[3];
    float   deriv[3];
    track->Evaluate_Derivative(posn_on_track, deriv);
    track->Evaluate_Point(posn_on_track, point);
    
    
    [camera setPositionX:point[0]+.1*deriv[0]
               positionY:point[1]+.1*deriv[1]
               positionZ:point[2]+1 
              directionX:deriv[0]
              directionY:deriv[1]
              directionZ:deriv[2]
     ];
//    NSLog(@"%@",camera);
    
}




@end
