//
//  VNTIView.m
//  VNTI
//
//  Created by vad zimin on Fri Aug 29 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import "VNTIView.h"


@implementation VNTIView

float ratio;

-(BOOL) isOpaque {
    return YES;
}
- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    
    if (self) {
	/*    
        txtAttr = [[NSMutableDictionary dictionaryWithCapacity:2] retain];
        [txtAttr setObject:[NSFont fontWithName:@"Arial" size:12] forKey:NSFontAttributeName];
        [txtAttr setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];

        txtBuff=[[NSImage alloc] initWithSize:NSMakeSize(250,20)];
        [txtBuff lockFocus];
        [[NSString stringWithString:@"Vector NTI Demo Screen Saver"] drawAtPoint:NSMakePoint(0,0) withAttributes:txtAttr];
        [txtBuff unlockFocus];
    */
	txtBuff=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"string"]];        
	mX=NSMaxX(frame);
	mY=NSMaxY(frame);
	int i;
	for (i=0; i<100; i++) {
    	    imgs[i]=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:[NSString stringWithFormat:@"DNK%04d",i]]];
        
	}
	buf=[[NSImage alloc] initWithSize:[imgs[0] size]];
	[buf setCacheMode: NSImageCacheNever];
	[buf lockFocus];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationNone];
	[buf unlockFocus];
	ratio=[buf size].width/[buf size].height;
	refr=[self bounds];
    
    
	t=0; step=0.01;
	currentFrame=0;
	x=mX; y=mY;
	tX=15; tT=0.1;
	prevMode=isPreview;
        [self setAnimationTimeInterval:1/25.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    
    //NSRectFillUsingOperation([self bounds], NSCompositeCopy);
    
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
     [[NSColor blackColor] set];
     NSRectFill(refr);
    
    if (prevMode) {
        [buf setScalesWhenResized:NO];
        [buf setSize:[imgs[currentFrame] size]];
        [buf lockFocus];
        [imgs[currentFrame] compositeToPoint:NSMakePoint(0,0) operation:NSCompositeCopy];
        [buf unlockFocus];
        [buf setScalesWhenResized:YES];
        [buf setSize: NSMakeSize([self bounds].size.height*ratio, [self bounds].size.height)];
        [buf compositeToPoint:NSMakePoint([self bounds].size.width/2-[buf size].width/2,0) operation:NSCompositeCopy];
        refr=[self bounds];
        return;
    }
    
    NSRectFillUsingOperation(NSMakeRect(15,15,[txtBuff size].width,[txtBuff size].height), NSCompositeCopy);
    [buf setScalesWhenResized:NO];
    [buf setSize: [imgs[currentFrame] size]];
    [buf lockFocus];
    
  /*  
    void* port=[[NSGraphicsContext currentContext] graphicsPort];
    CGContextRotateCTM (port, pi/4);
    float col[4]={1.0, 0.0, 0.0, 1.0};
    float gcol[4]={0.0, 1.0, 0.0, 1.0};
    CGContextSetStrokeColor(port,  col);
    CGContextSetFillColor(port,  gcol);
    CGContextShowText(port,"aklsjdfgasjklf",14);
    CGContextFillRect(port, CGRectMake(10,10,20,20));
 */   
    [imgs[currentFrame] compositeToPoint:NSMakePoint(0,0) operation:NSCompositeCopy];
    [buf unlockFocus];
    [buf setScalesWhenResized:YES];
    [buf setSize: NSMakeSize(mX/14.0*z+150,(mX/14.0*z+150)/ratio)];
    NSPoint pos=NSMakePoint(x*mX/(3-z)+mX/2-[buf size].width/2, y*mY/(3-z)+mY/2-[buf size].height/2);
    
    [buf compositeToPoint:pos operation: NSCompositeCopy fraction: 0.6+z/4.0];
    refr=NSMakeRect(pos.x-3,pos.y-3,[buf size].width+3, [buf size].height+3);
    
    [txtBuff compositeToPoint:NSMakePoint(15,15) operation:NSCompositeSourceOver fraction: tT];

    
}

- (void)animateOneFrame
{
    if (currentFrame>=99) currentFrame=0; else currentFrame++;
    x=sin(t); 
    //float alpha=pi/2;
   // y=cos(t)*sin(sin(t*alpha/(2*pi)));
   // z=cos(t)*cos(sin(t*alpha/(2*pi)));
    y=cos(t)*sin(sin(t));
    z=cos(t)*cos(sin(t));
    t+=step;
    //if (tX+120<mX) tX++;
    tX=15; 
    tT=cos(t*2+pi)/2.5+0.5;
    [self setNeedsDisplay:YES];
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
