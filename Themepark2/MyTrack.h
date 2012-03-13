//
//  MyTrack.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenGLObject.h"
#import <OpenGL/gl.h>
#include "CubicBspline.h"

@interface MyTrack : OpenGLObject{
    GLubyte 	    track_list;	    // The display list for the track.
    GLubyte 	    train_list;	    // The display list for the train.
    bool    	    initialized;    // Whether or not we have been initialized.
    CubicBspline    *track;	    // The spline that defines the track.
    float	    posn_on_track;  // The train's parametric position on the
    // track.
    float	    speed;	    // The train's speed, in world coordinates
    
    int	TRACK_NUM_CONTROLS;	// Constants about the track.
    float** 	TRACK_CONTROLS;
    float 	TRAIN_ENERGY;
}


- (void) Normalize_3: (float*) v;


- (id) init;
- (bool) initialize;
- (void) update: (float) dt;
- (void) draw;
- (void) dealloc;

@end
