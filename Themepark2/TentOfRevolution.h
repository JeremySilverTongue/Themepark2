//
//  TentOfRevolution.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenGLObject.h"

@interface TentOfRevolution : OpenGLObject{
    GLubyte display_list;   // The display list that does all the work.
    bool    initialized;    // Whether or not we have been initialised.    
}    


- (id) init;


- (bool) initialize;

- (void) draw;

- (void) dealloc;

@end
