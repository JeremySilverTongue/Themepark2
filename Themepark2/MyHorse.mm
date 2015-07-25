//
//  MyHorse.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyHorse.h"

@implementation MyHorse

- (id) init{
    self = [super init];
    initialized = false;
    return self;
}



    
    
    
- (bool) initialize{
    return [self initializeWithHeight:1.0f];
}

- (bool) initializeWithHeight: (float) heightInput{
    height=heightInput;
    return true;
}

- (void) draw{
    [self drawAtHeight:0.5f];
}




- (void) drawAtHeight: (float) heightInput{
  
    glColor3f(0, 0, 0);
    glBegin(GL_LINES);
    glVertex3f(0.0f, 0.0f, 0.0f);
    glVertex3f(0.0f, 0.0f, height);
    glEnd();
    
   glColor3f(1, 1, 1);
    
    glPushMatrix();
    glTranslatef(0,0,height/4+height*heightInput/2);
    glutSolidSphere((float)height/8,10, 10);
//    glutSolidTeapot(height/8);
    glPopMatrix();
    

    
    
}



- (void) dealloc
{
    [super dealloc];
}








@end
