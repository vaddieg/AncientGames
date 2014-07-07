//
//  cockSaverView.m
//  cockSaver
//
//  Created by vad zimin on Fri Jul 11 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import "cockSaverView.h"


@implementation cockSaverView 

+(BOOL)performGammaFade{
    return YES;
}
-(BOOL) isOpaque {
    return YES;
}
-(void)sound:(NSSound *)sound didFinishPlaying:(BOOL)aBool{
    [sound performSelector:@selector(play) withObject:nil afterDelay:0];
}
- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
	//[[self window] setBackgroundColor:[NSColor clearColor]];
	if (!isPreview)
		[[self window] setAlphaValue:0.5];
    if (self)  {       [self setAnimationTimeInterval:1/20.0];
        
    prevMode=isPreview;
    mX=NSMaxX(frame);
    mY=NSMaxY(frame);
    //NSLog(@"View size : %d,%d",mX,mY);
    if (!isPreview) {
        x=mX; y=200; spy=0; spx=-5;
        snd=[[NSSound alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForSoundResource:@"ambientloop"] byReference:NO];
		frogSnd = [[NSSound alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForSoundResource:@"frog shot"] byReference:NO];
    
    }
    else {x=20; y=20;}
    curFrame=0;
    curRabFrame=0;
    curIgelFrame=0;
	curFrogFrame=0;
    rabX=SSRandomIntBetween(10, mX*4-105);
    igelX=SSRandomIntBetween(10, mX*4-105);
    frogX=SSRandomIntBetween(10, mX*4-105);
       
    flyingCock=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"cockLeft"]];
        //NSLog(sourceFile);
    rabbit=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"rabbit"]];
    igel=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"igelupdown"]];
	frog=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"moorfrosch"]];
	
    if (flyingCock==nil) NSLog(@"cock not loaded");
    rabMov=1; igelMov=1; frogMov=1;
    cockRect=frame;
	// preparing txt
	NSFileManager* fm = [NSFileManager defaultManager];
	NSString* txtPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/Speech.txt"];
	if (![fm fileExistsAtPath:txtPath]) {
		// dumb create dirs
		[fm createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] attributes:nil];
		[fm createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support"]  attributes:nil];
		// copy default file
		NSString* src = [[NSBundle bundleForClass:[self class]] pathForResource:@"DefaultPhrases" ofType:@"txt"];
		if (![fm copyPath:src toPath:txtPath handler:nil])
			NSLog(@"cant copy phrases");
	}
	// initing phrases
	NSString* content = [NSString stringWithContentsOfFile:txtPath];
	_phrases = [[content componentsSeparatedByString:@"\n"] retain];
    }
    return self;
}
-(void)dealloc {
	[flyingCock release];
	[rabbit release];
	[igel release];
	[frog release];
	[snd release];
	[frogSnd release];
	[_phrases release];
	[super dealloc];
}
- (void)startAnimation
{
    [super startAnimation];
	//[[NSColor blackColor] set];
   // NSRectFill([self frame]);
   	
    if (!prevMode) {
    [snd setDelegate:self];
    [snd play];
    }
}

- (void)stopAnimation
{
    
    if (!prevMode) {
    [snd setDelegate:nil];
    [snd stop];
    }
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect {
	//[[NSColor purpleColor] set];
	//[[self _baloonOfSize:NSMakeSize(200,150)]stroke];
    [[NSColor blackColor] set];

    if (!prevMode) {
        NSRectFill(cockRect);
        NSRectFill(igelRect);
        NSRectFill(rabRect);
		 NSRectFill(frogRect);
		NSRectFill( _balRect);
    } else  NSRectFillUsingOperation([self frame],NSCompositeCopy);
	
	[flyingCock compositeToPoint:NSMakePoint(x,y) fromRect:NSMakeRect(0,2020-(curFrame+1)*101,107,101) operation:NSCompositeSourceOver];
    cockRect=NSMakeRect(x,y,110,110);

    if (rabX<mX-105)
      [rabbit compositeToPoint:NSMakePoint(rabX,1) fromRect:NSMakeRect(0,1920-(curRabFrame)*160,105,160) operation:NSCompositeSourceOver];
    rabRect=NSMakeRect(rabX,0,106,161);
    if (igelX<mX-105)
      [igel compositeToPoint:NSMakePoint(igelX,1) fromRect:NSMakeRect(0,276-(curIgelFrame)*46,98,46) operation:NSCompositeSourceOver];
      igelRect=NSMakeRect(igelX,0,98,50);
	
	if (frogX<mX-105)
		 [frog compositeToPoint:NSMakePoint(frogX,1) fromRect:NSMakeRect(0,1600-(curFrogFrame)*100,173,100) operation:NSCompositeSourceOver];
    frogRect=NSMakeRect(frogX,0,174,101);

	if (_baloon)
		[_baloon compositeToPoint:_balPos operation:NSCompositeSourceOver];
   // NSLog(@"drawrect");
  // [[self window] setNeedsDisplay:YES];
    
}

- (void)animateOneFrame
{
	// cock
    x+=spx;y+=spy;
    if ((x<-100)||(x>mX)) {x=mX; y=SSRandomIntBetween(100,mY-100);}
    if (curFrame<19) curFrame++; else curFrame=0;
	
    if (odd==2) {
		// other anmals
		curRabFrame+=rabMov;
		curIgelFrame+=igelMov;
		curFrogFrame+=frogMov;
      if ((curRabFrame==0)||(curRabFrame==12)) rabMov=-rabMov;
      if (curRabFrame==0) rabX=SSRandomIntBetween(10, mX*4);
      
	  if ((curIgelFrame==0)||(curIgelFrame==6)) igelMov=-igelMov;
      if (curIgelFrame==0) igelX=SSRandomIntBetween(10, mX*4); 
	}
	
	if ((curFrogFrame==0)||(curFrogFrame==16)) {
		frogMov=-frogMov; 
		// start baloon
		
	}
	if (!_baloon && (curFrogFrame==16))
		if (SSRandomIntBetween(0,1)==1)
			[self createBaloonAtPoint:NSMakePoint(frogX+110, 40) delay:45];
	
	if (!_baloon && (curRabFrame==12))
		[self createBaloonAtPoint:NSMakePoint(rabX+100, 40) delay:35];
	
	if (!_baloon && (curIgelFrame==6))
		[self createBaloonAtPoint:NSMakePoint(igelX+120, 20) delay:20];
	
	if (curFrogFrame==0) {
		frogX=SSRandomIntBetween(10, mX*4);
		//[frogSnd play];
	}

	if (baloonLife > baloonDuration) {
		[_baloon release];
		_baloon = nil;
	}
	if (_baloon) baloonLife++;
	
    if (odd<2) odd++; else odd=0;
    [self setNeedsDisplay:YES];
   
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

-(NSBezierPath*)_baloonOfSize:(NSSize)size {
	NSBezierPath* p = [NSBezierPath bezierPath];
	[p moveToPoint:NSZeroPoint];
	[p lineToPoint:NSMakePoint(90,0)];
	//[p appendBezierPathWithArcFromPoint:NSMakePoint(90,0) toPoint:NSMakePoint(100,10) radius:10];
	[p appendBezierPathWithArcWithCenter:NSMakePoint(90,10) radius:10 startAngle:270 endAngle:360 clockwise:NO];
	[p lineToPoint:NSMakePoint(100,50)];
	//[p appendBezierPathWithArcFromPoint:NSMakePoint(100,50) toPoint:NSMakePoint(90,60) radius:10];
	[p appendBezierPathWithArcWithCenter:NSMakePoint(90,50) radius:10 startAngle:0 endAngle:90 clockwise:NO];
	[p lineToPoint:NSMakePoint(30,60)];
	//[p appendBezierPathWithArcFromPoint:NSMakePoint(30,60) toPoint:NSMakePoint(20,50) radius:10];
	[p appendBezierPathWithArcWithCenter:NSMakePoint(30,50) radius:10 startAngle:90 endAngle:180 clockwise:NO];
	
	[p lineToPoint:NSMakePoint(20,20)];
	// last arc
	//[p appendBezierPathWithArcFromPoint:NSMakePoint(20,20) toPoint:NSMakePoint(0,0) radius:20];
	[p appendBezierPathWithArcWithCenter:NSMakePoint(0,20) radius:20 startAngle:0 endAngle:270 clockwise:YES];
	

	NSAffineTransform* tr = [NSAffineTransform transform];
	[tr scaleXBy:size.width/100 yBy:size.height/60];
	[p transformUsingAffineTransform:tr];
	return p;
}

-(void)createBaloonAtPoint:(NSPoint)pnt delay:(int) frames{
	if (!_phrases) return;
	if (pnt.x+120 > mX) return;
	if (SSRandomIntBetween(0,3)!=2) return;
	baloonLife = 0;
	baloonDuration = frames;
	_balPos = pnt;
	NSString* text = [_phrases objectAtIndex:SSRandomIntBetween(0,[_phrases count]-1)];
	NSAttributedString* as = [[NSAttributedString alloc] initWithString:text attributes:[
	NSDictionary dictionaryWithObjectsAndKeys:
		[NSColor whiteColor], NSBackgroundColorAttributeName,
		[NSColor blackColor], NSForegroundColorAttributeName,
		[NSFont fontWithName:@"Comic Sans MS" size:13], NSFontAttributeName,
		nil
	]];
	[_baloon release];
	_baloon = [[NSImage alloc] initWithSize:NSMakeSize(140,90)];
	[_baloon lockFocus];
	[[NSColor whiteColor] set];
	//NSRectFill(NSMakeRect(0,0,120,80));
	[[self _baloonOfSize:NSMakeSize(140,90)] fill];
	[as drawInRect:NSMakeRect(35,5,110,70)];
	[_baloon unlockFocus];
	_balRect = NSMakeRect(pnt.x,pnt.y,140,90);
}


/*
- (NSWindow*)configureSheet
{
    if (!winCont) {winCont=[[NSWindowController alloc] initWithWindowNibPath:@"/Library/Screen Savers/cockSaver.saver/Contents/Resources/cockConfigSheet.nib" owner:self];
    NSLog(@"loading NIB");
    }
    if (!winCont) NSLog(@"NIB load unsuccessful");
    [winCont loadWindow];
    return [winCont window];
}*/

@end
