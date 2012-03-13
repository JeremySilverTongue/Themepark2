//
//  MyCarousel.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyCarousel.h"

@implementation MyCarousel

- (id) init {
    self = [super init];
    initialized = false; rotation = 0.0f; speed = 1.0f;
    return self;
}

- (void) dealloc{
    if ( initialized )
    {
        glDeleteLists(carousel_list, 1);
        glDeleteLists(horse_list, 1);
    }
}



- (bool) initialize{    
    // Set up the train. At this point a cube is drawn. NOTE: The
    // x-axis will be aligned to point along the track. The origin of the
    // train is assumed to be at the bottom of the train.
    carousel_list = glGenLists(1);
    glNewList(carousel_list, GL_COMPILE);
    
    glColor3f(1.0, 0.0, 0.0);
    glBegin(GL_TRIANGLE_FAN);
    
    glVertex3f(0.0f, 0.0f, 0.0f);    // A
    int numSegments= 10;
    float radius=5;
    float x,y;
    
    
    for (int segment=0; segment<=numSegments; segment++) {
        
        if (segment&2==1) {
            glColor3f(0.0, 1.0, 0.0);
        } else {
            glColor3f(0.0, 0.0, 1.0);
        }
        
        x= radius*cosf(2*M_PI*segment/numSegments);
        y = radius*sinf(2*M_PI*segment/numSegments);
        
        glVertex3f( x,  y, 0.0f);
    }
    
    
    glEnd();

    glEndList();
    
    initialized = true;
    
    return true;
}


- (void) draw{
    
    glPushMatrix();
    

    glTranslatef(20,20, 20);
    glRotatef((float)M_PI*2*rotation, 0.0f, 0.0f, 1.0f);


    glCallList(carousel_list);
    
    glPopMatrix();

    
    
}









- (void) update: (float) dt{
    rotation += dt*speed;
    if (rotation>1) {
        rotation=1;
    }
}







@end
