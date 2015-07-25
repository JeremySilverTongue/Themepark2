//
//  TentOfRevolution.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TentOfRevolution.h"

@implementation TentOfRevolution

-(id) init{
    
    self =[super init];
    if (self) {
        display_list = 0; initialized = false; 
    }
    
    NSLog(@"Ground init");
    return self;
}



- (bool) initialize{
    
    float tentSurface[11][2]={
        {20,0},
        {20,5},
        {18,10},
        {15,15},
        {10,20},
        {8,20},
        {6,20},
        {4,20},
        {2,20},
        {0,30},
        {0,30}
    };
    
    
    
    display_list = glGenLists(1);
    glNewList(display_list, GL_COMPILE);
	// Use white, because the texture supplies the color.
	glColor3f(1, 1, 1);
    
    int numberOfSlices=15;
    int numberOfStacks=11;
    float phi, nextPhi;
    float radius, nextRadius;
    float elevation, nextElevation;
    
    for (int stack = 0; stack < numberOfStacks-1; stack++){
        radius=tentSurface[stack][0];
        elevation=tentSurface[stack][1];
        nextRadius=tentSurface[stack+1][0];
        nextElevation=tentSurface[stack+1][1];
        
        glBegin(GL_TRIANGLE_STRIP);
        for (int slice = 0; slice<numberOfSlices+1; slice++){
            phi=2*M_PI*slice/numberOfSlices;
            nextPhi=2*M_PI*(slice+1)/numberOfSlices;
//            glColor3f((float) random()/RAND_MAX, (float) random()/RAND_MAX, (float) random()/RAND_MAX);
            
            glVertex3d(radius*cos(phi), radius*sin(phi), elevation);
            glColor3f((float) random()/RAND_MAX, (float) random()/RAND_MAX, (float) random()/RAND_MAX);
            glVertex3d(nextRadius*cos(phi), nextRadius*sin(phi), nextElevation);
//            glVertex3d(radius*cos(nextPhi), radius*sin(nextPhi), elevation);
//            glVertex3d(nextRadius*cos(phi), radius*sin(phi), elevation);
        }
        glEnd();
    }
        

    glEndList();
    
    // We only do all this stuff once, when the GL context is first set up.
    initialized = true;
    

    return true;
}


- (void) draw{
    glPushMatrix();
    
    glTranslated(25, -25, 0);
    glCallList(display_list);
    glPopMatrix();
    
}

- (void) dealloc{
    if ( initialized )
    {
        glDeleteLists(display_list, 1);
    }
}




@end

