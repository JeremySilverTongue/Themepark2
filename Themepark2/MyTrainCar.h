//
//  MyTrainCar.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenGLObject.h"


@interface MyTrainCar : OpenGLObject{
    GLubyte car_list;	
    bool initialized;    // Whether or not we have been initialized.
    float distanceBetweenCars;
    
    
}


- (id) init;
- (bool) initialize;
- (void) draw;
- (void) drawOnTrack: (CubicBspline*) track atPosition: (float) position carNumber: (int) carNumber;
                       
                       
                       
- (void) dealloc;

@end
