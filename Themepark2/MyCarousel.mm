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
    initialized = false; rotation = 0.0f; speed = 0.1f;
    numberOfHorses = 10;
    horses = [[NSMutableArray alloc] initWithCapacity:numberOfHorses];
    for (int horseIndex=0; horseIndex<numberOfHorses; horseIndex++) {
        [horses addObject:[[MyHorse alloc] init]];
    }
    
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
//  Setting up the base of the carosel
    
    carousel_list = glGenLists(1);
    glNewList(carousel_list, GL_COMPILE);

    glColor3f(1.0, 0.0, 0.0);
    glShadeModel	(	GL_FLAT );
    glBegin(GL_TRIANGLE_FAN);
    glNormal3f(0.0f, 0.0f, 1.0f);
    glVertex3f(0.0f, 0.0f, 0.0f);    
    int numSegments= 10;
    radius=5;
    float x,y;
    
    for (int segment=0; segment<=numSegments; segment++) {
        
        if (segment%2==1) {
            glColor3f(0.0, 1.0, 0.0);
        } else {
            glColor3f(0.0, 0.0, 1.0);
        }
        
        x= radius*cosf(2*M_PI*segment/numSegments);
        y = radius*sinf(2*M_PI*segment/numSegments);
        glNormal3f(0.0f, 0.0f, 1.0f);
        glVertex3f( x,  y, 0.0f);
    }
    
    
    
    glEnd();
    
    glBegin(GL_TRIANGLE_FAN);
    glNormal3f(0.0f, 0.0f, 1.0f);
    glVertex3f(0.0f, 0.0f, radius);    
    
    for (int segment=0; segment<=numSegments; segment++) {
        
        if (segment%2==1) {
            glColor3f(0.0, 1.0, 0.0);
        } else {
            glColor3f(0.0, 0.0, 1.0);
        }
        
        x= radius*cosf(2*M_PI*segment/numSegments);
        y = radius*sinf(2*M_PI*segment/numSegments);
        glNormal3f(0.0f, 0.0f, 1.0f);
        glVertex3f( x,  y, radius);
    }
    glEnd();
    
    glBegin(GL_TRIANGLE_FAN);
    glNormal3f(0.0f, 0.0f, 1.0f);
    glVertex3f(0.0f, 0.0f, 1.3*radius);    
    
    for (int segment=0; segment<=numSegments; segment++) {
        
        if (segment%2==1) {
            glColor3f(0.0, 1.0, 0.0);
        } else {
            glColor3f(0.0, 0.0, 1.0);
        }
        
        x= radius*cosf(2*M_PI*segment/numSegments);
        y = radius*sinf(2*M_PI*segment/numSegments);
        glNormal3f(0.0f, 0.0f, 1.0f);
        glVertex3f( x,  y, radius);
    }
    glEnd();
    
    
    
    
    
    glEndList();
    
    
    
// setting up horses
    
    for (MyHorse * horse in horses) {
        [horse initializeWithHeight:radius];
//        [horse initialize];
    }
//    
    
    
    initialized = true;
    
    return true;
}


- (void) draw{
    
    glPushMatrix();
    

    glTranslatef(-20,-20, .1);
    glRotatef((float)360*rotation, 0.0f, 0.0f, 1.0f);
    glCallList(carousel_list);
    
    float horseHeight;
    int horseIndex=0;
    for (MyHorse* horse in horses) {
        horseIndex++;
        
        glRotatef(360./numberOfHorses, 0, 0, 1);
        glTranslatef(.7*radius, 0, 0);
        horseHeight= sin(6*M_PI*(rotation+((float)horseIndex)/numberOfHorses));
        
        
        [horse drawAtHeight:.5+horseHeight/2];
        glTranslatef(-.7*radius, 0, 0);
    }
    
    
    
    
    glPopMatrix();
    
    

    
    
    
    
    

    
    
}









- (void) update: (float) dt{
    rotation += dt*speed;
    if (rotation>1) {
        rotation=0;
    }
}







@end
