//
//  MyCarousel.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenGLObject.h"

@interface MyCarousel : OpenGLObject{
    float rotation;
    GLubyte carousel_list;	    // The display list for the track.
    GLubyte horse_list;	
    bool    	    initialized;    // Whether or not we have been initialized.
    float	    speed;	    // The train's speed, in world coordinates
}




- (id) init;
- (bool) initialize;
- (void) update: (float) dt;
- (void) draw;
- (void) dealloc;



@end
