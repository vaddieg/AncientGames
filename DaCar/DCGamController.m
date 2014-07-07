#import "DCGamController.h"
#import "DCSceneController.h"
#import "DCRadarObject.h"
#import "DCTerrainObject.h"
#import "VZGameKit.h"

DCSceneController* _scene, *_secScene;

@implementation DCGamController

- (IBAction)start:(id)sender
{
    NSLog(@"start (add objt)");
    VZActiveObject* ob=[[VZActiveObject new] autorelease];
    [ob setSpeed: NSMakePoint(3,4)];
    [ob setControlledByUser:YES];
	[ob setLayer:2];
	[ob setMargines: [_view bounds]];
    [_scene addObject: ob];
	
    //[_scene start];
	if (_secScene) {
		VZActiveObject* ob=[[VZActiveObject new] autorelease];
		[ob setSpeed: NSMakePoint(5,1)];
		[ob setControlledByUser:NO];
		[ob setLayer:2];
		[ob setMargines: [[_scene view] bounds]];
		[_secScene addObject: ob];
	}
}
- (IBAction)nextScene: (id)sender{
    NSLog(@"next");
	
    _scene=[[[DCSceneController alloc] initWithDictionary: nil superview: _view inRect: [_view bounds]] autorelease];
	DCBackroundObject* ob=[[DCBackroundObject new] autorelease];
	[ob setMargines: [_view bounds]];
	[_scene addObject:ob];
    [self setScene:_scene];
    [_scene startWithFPS: 30];
	/*_secScene=[[DCSceneController alloc] initWithDictionary: nil superview: [_scene view] inRect: NSMakeRect(40,40,50,50)];
	[_secScene startWithFPS:10];*/
}
- (void) sceneFinished: (NSNotification*) not{
    //[[not object] release];
    //[self startNextScene];
}

- (void) awakeFromNib{
    NSLog(@"nibas");
	[super awakeFromNib];
    _scene=[[[DCSceneController alloc] initWithDictionary: nil superview: _view inRect: [_view bounds]] autorelease];
	
	VZActiveObject* ob;
	/*	
	ob=[[[DCBackroundObject alloc] initWithTileImage: @"sky" ] autorelease];
	[ob setLayer: 0];
	[ob setMargines: [_view bounds]];
	[_scene addObject:ob];
	*/
	/*
	ob=[[[DCBackroundObject alloc] initWithTileImage: @"sky_trans" ] autorelease];
	[ob setLayer: 8];
	[ob setSpeed: NSMakePoint(-1, 3)];
	[ob setMargines: [_view bounds]];
	[_scene addObject:ob];*/
	
	ob=[[[DCTerrainObject alloc] initWithDictionary: nil] autorelease];
	[_scene addObject:ob];
	
	
	DCAircraftObject* ob2=[[[DCAircraftObject alloc] initWithDictionary: nil] autorelease];
    //[ob2 setSpeed: NSMakePoint(0,0)];
    [ob2 setControlledByUser:YES];
	[ob2 setTarget:ob];
	[ob2 setLayer:5];
	[ob2 setMargines: [_view bounds]];
	[ob2 setKind:@"MyAircraft"];
    [_scene addObject: ob2];

	DCRadarObject* radar=[[[DCRadarObject alloc] initWithDictionary: nil] autorelease];
	[_scene addObject:radar];
	NSLog(@"radar initialized");  
	[_scene setCentralObject: ob2];
	[_scene setRadarObject: radar];
    [self setScene:_scene];
    [_scene startWithFPS: 30];   
}

    

@end
