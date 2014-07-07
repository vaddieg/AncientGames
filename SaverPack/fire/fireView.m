//
//  fireView.m
//  fire
//
//  Created by vad zimin on Wed Sep 10 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import "fireView.h"

#define FIRE_WIDTH 300
#define FIRE_HEIGHT 90

@implementation fireView

NSBitmapImageRep *im;
int t;
NSRect fireRect;
NSRect sourceRect;
unsigned long i,lastByte, bytesInRow; // offsets
unsigned char *data;
// reduces defines color offsets relative to white point (255,255,255)
unsigned char greenReduce=75;
unsigned char blueReduce=120;
BOOL bgIsBlack;

- (BOOL) isOpaque {
    return YES;
}
- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        fireRect=NSMakeRect(0,-4,frame.size.width,frame.size.height/3);
		sourceRect=NSMakeRect(0,0,/*400*/FIRE_WIDTH,/*100*/FIRE_HEIGHT);
		
        im=[[NSBitmapImageRep alloc] initWithBitmapDataPlanes: NULL 
        pixelsWide: sourceRect.size.width
        pixelsHigh: sourceRect.size.height
        bitsPerSample: 8
        samplesPerPixel: 3
        hasAlpha:NO
        isPlanar:NO
        colorSpaceName:NSDeviceRGBColorSpace
        bytesPerRow: sourceRect.size.width*3
        bitsPerPixel: 24
        ];
        data=[im bitmapData];
        bytesInRow=sourceRect.size.width*3;
        lastByte=sourceRect.size.width*3*sourceRect.size.height;

        
        [self setAnimationTimeInterval:1/24.0];
        bgIsBlack = NO;
    }
    return self;
}

- (void)startAnimation
{
    [[NSColor blackColor] set];
    [super startAnimation];
    
}

- (void)stopAnimation
{
    
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{	if (!bgIsBlack) {
		if (rect.size.height>FIRE_WIDTH)
			NSRectFillUsingOperation(rect, NSCompositeCopy);
		else NSRectFillUsingOperation([self frame], NSCompositeCopy);
		bgIsBlack = YES;
    }
    [im drawInRect:fireRect];
}

- (void)animateOneFrame
{
    long v;
    long sum=0;
   
    t++;
    if (!(t%2)) {// filling first row
//	for (i=lastByte-3; i> lastByte-bytesInRow; i-=3) *(data+i)=150;
		for (i=lastByte-3; i>lastByte-bytesInRow; i-=3) {
			sum+=rand()%254-50;
    	    *(data+i)=sum/3;
			//*(data+i)=rand()%255;
	    
		}
    }
   
    for (i=lastByte-bytesInRow-3; i>0; i-=3) {
	
		v=(long)((*(data+i-3)+*(data+i+3)+*(data+i+bytesInRow))/3);
        
		if (t%2==0) v--;
		//v-=2;
		if ((v>15)&&(rand()%15000==1000)) v=255; // sparks
        if (v>0) {
                *(data+i)=v;					//R
                *(data+i+1)=(((long)v-greenReduce)<0)? 0: (long) v-greenReduce;	//G
                *(data+i+2)=(((long)v-blueReduce)<0)? 0: (long) v-blueReduce;	//B
   
		} else {

                *(data+i)=0;
        }            
        
    }
    [self setNeedsDisplayInRect:fireRect];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
