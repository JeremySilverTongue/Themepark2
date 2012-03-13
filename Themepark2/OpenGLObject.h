//
//  OpenGLObject.h
//  Themepark2
//
//  Created by Jeremy Silver on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGL/gl.h"
#import "math.h"


@interface OpenGLObject : NSObject{
    
}

-(id) init;

- (void) dealloc;
-(void) makeTextureFromImage:(NSImage*)theImg forTexture:(GLuint*)texName;

@end
