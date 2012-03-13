//
//  MyGround.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyGround.h"
#include <OpenGl/glu.h>

@implementation MyGround

-(id) init{
    
    self =[super init];
    if (self) {
        display_list = 0; initialized = false; 
    }
    
    NSLog(@"Ground init");
    return self;
}
    
- (bool) initialize{
    NSImage* grassTexture = [NSImage imageNamed:@"grass-texture.png"];
    glGenTextures(1, &texture_obj);


    [self makeTextureFromImage:grassTexture forTexture:&texture_obj];
     
    
    glBindTexture(GL_TEXTURE_2D, texture_obj);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
                    GL_NEAREST_MIPMAP_LINEAR);
    
    // This says what to do with the texture. Modulate will multiply the
    // texture by the underlying color.
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE); 
    
    display_list = glGenLists(1);
    glNewList(display_list, GL_COMPILE);
	// Use white, because the texture supplies the color.
	glColor3f(1.0, 1.0, 1.0);
    
	// The surface normal is up for the ground.
	glNormal3f(0.0, 0.0, 1.0);
    
	// Turn on texturing and bind the grass texture.
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, texture_obj);
    
	// Draw the ground as a quadrilateral, specifying texture coordinates.
	glBegin(GL_QUADS);
    glTexCoord2f(100.0, 100.0);
    glVertex3f(50.0, 50.0, 0.0);
    glTexCoord2f(-100.0, 100.0);
    glVertex3f(-50.0, 50.0, 0.0);
    glTexCoord2f(-100.0, -100.0);
    glVertex3f(-50.0, -50.0, 0.0);
    glTexCoord2f(100.0, -100.0);
    glVertex3f(50.0, -50.0, 0.0);
	glEnd();
    
	// Turn texturing off again, because we don't want everything else to
	// be textured.
	glDisable(GL_TEXTURE_2D);
    glEndList();
    
    // We only do all this stuff once, when the GL context is first set up.
    initialized = true;

    NSLog(@"Ground initialized");
    return true;
}


- (void) draw{
    glPushMatrix();
    glCallList(display_list);
    glPopMatrix();
}

- (void) dealloc{
    if ( initialized )
    {
        glDeleteLists(display_list, 1);
        glDeleteTextures(1, &texture_obj);
    }
}




@end
