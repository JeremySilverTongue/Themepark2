//
//  MySidewalk.m
//  Themepark2
//
//  Created by Jeremy Silver on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MySidewalk.h"

@implementation MySidewalk
-(id) init{
    
    self =[super init];
    if (self) {
        display_list = 0; initialized = false; 
    }
    
    NSLog(@"Ground init");
    return self;
}

- (bool) initialize{
    NSImage* image = [NSImage imageNamed:@"sidewalk-texture"];
    NSRect bigRect;
    NSBitmapImageRep* upsideDown, *imageRep;
    long bytesPerRow, bitsPerPixel, height;
    bool hasAlpha;
    GLuint sidewalkTex;
    
    
    bigRect.origin = NSZeroPoint;
    bigRect.size = [image size];
    [image lockFocus];
    upsideDown = [[NSBitmapImageRep alloc] initWithFocusedViewRect: bigRect];
    [image unlockFocus];
//    [image release];
    unsigned char * from, * to;
    
    //    NSLog(@"%@",upsideDown);
    
    // since OpenGL draws images upside down, we need to flip this image along 
    // the y axis. I know a cool trick for doing this when texture mapping, 
    // but I want something a little more general for now
    bytesPerRow = [upsideDown bytesPerRow];
    bitsPerPixel = [upsideDown bitsPerPixel];
    hasAlpha = [upsideDown hasAlpha];
    height = (int)bigRect.size.height;
    imageRep = [[NSBitmapImageRep alloc] 
                initWithBitmapDataPlanes:NULL
                pixelsWide:(int)bigRect.size.width
                pixelsHigh:height
                bitsPerSample:[upsideDown bitsPerSample]
                samplesPerPixel:[upsideDown samplesPerPixel]
                hasAlpha:hasAlpha
                isPlanar:[upsideDown isPlanar]
                colorSpaceName:NSCalibratedRGBColorSpace
                bytesPerRow:bytesPerRow
                bitsPerPixel:bitsPerPixel];
    from = [upsideDown bitmapData];
    to = [imageRep bitmapData];
    for (int i = 0; i < height; i++) {
        bcopy((from + bytesPerRow * i), (to + bytesPerRow * (height - i - 1)), bytesPerRow);
    }
//    [upsideDown release];
    
    // create the texture
    if (TRUE) {
        GLenum format;
        
        format = hasAlpha ? GL_RGBA : GL_RGB;
        glGenTextures(1, &sidewalkTex);
        glBindTexture(GL_TEXTURE_2D, sidewalkTex);
        //        CheckGLError("glBindTexture");
        //        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        //        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        //        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        //        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        //        CheckGLError("glTexParameteri");
        glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
        glPixelStorei(GL_UNPACK_ROW_LENGTH, bytesPerRow / (bitsPerPixel >> 3));
        //        CheckGLError("glPixelStorei");
        //        glTexImage2D(GL_TEXTURE_2D, 
        //                     0, 
        //                     GL_RGBA, 
        //                     bigRect.size.width, 
        //                     bigRect.size.height, 
        //                     0, 
        //                     format, 
        //                     GL_UNSIGNED_BYTE, 
        ////                     to
        //                     [imageRep bitmapData]
        //                     );
        
        gluBuild2DMipmaps(
                          GL_TEXTURE_2D, 3,
                          bigRect.size.width, 
                          bigRect.size.height, 
                          format, 
                          GL_UNSIGNED_BYTE, 
                          //                     to
                          [imageRep bitmapData]
                          );
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
                        GL_NEAREST_MIPMAP_LINEAR);
        glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE); 
        //        CheckGLError("glTexImage2D");
    }
    
    
    
    
    
    
    display_list = glGenLists(1);
    glNewList(display_list, GL_COMPILE);
	// Use white, because the texture supplies the color.
	glColor3f(1, 1, 1);
    
	// The surface normal is up for the ground.
	glNormal3f(0.0, 0.0, 1.0);
    
	// Turn on texturing and bind the grass texture.
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, sidewalkTex);
    
	// Draw the ground as a quadrilateral, specifying texture coordinates.
	glBegin(GL_QUADS);
    glTexCoord2f(1.0, 10.0);
    glVertex3f(5.0, 50.0, 0.1);
    
    glTexCoord2f(-1.0, 10.0);
    glVertex3f(-5.0, 50.0, 0.1);
    
    glTexCoord2f(-1.0, -10.0);
    glVertex3f(-5.0, -50.0, 0.1);
    
    glTexCoord2f(1.0, -10.0);
    glVertex3f(5.0, -50.0, 0.1);
    
    
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
