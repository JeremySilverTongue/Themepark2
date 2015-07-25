//
//  MyHorse.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenGLObject.h"

@interface MyHorse : OpenGLObject{
    float rotation;
    GLubyte horse_list;	
    bool    	    initialized;    // Whether or not we have been initialized.
    float height;
}




- (id) init;
- (bool) initializeWithHeight: (float) heightInput;
- (bool) initialize;
- (void) draw;
- (void) drawAtHeight: (float) height;
- (void) dealloc;
@end
