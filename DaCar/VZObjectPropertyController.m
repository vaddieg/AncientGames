#import "VZObjectPropertyController.h"
#import "VZActiveObject.h"


@implementation VZObjectPropertyController

- (id)initForObject:(VZActiveObject*)obj {
	self = [super init];
	if (self) {
		_propObject = [obj retain];
	}
	return self;
}

-(void)dealloc {
	//[_view];
	[_propObject release];
	[super dealloc];
}
-(NSString*)propertyNibName {
	return @"ActiveObjProps";
}

- (void)loadNibIfNeed {
	if (_nibLoaded) return;
	if ([NSBundle loadNibNamed:[self propertyNibName] owner:self]) _nibLoaded = YES;
	else NSLog (@"unable to load nib");
}

- (NSView*)view {
	[self loadNibIfNeed];
	return _view;
}

- (void)updateControls {
	[self loadNibIfNeed];
	[dirField setFloatValue:[_propObject direction]];
	[layField setFloatValue:[_propObject layer]];
	[lifeField setIntValue:[_propObject lifeTime]];
	[spField setFloatValue:[_propObject speedModule]];
	[xField setFloatValue:[_propObject pos].x];
	[yField setFloatValue:[_propObject pos].y];
	[activeSwitch setState:[_propObject isActive]];
	[userSwitch setState:[_propObject controlledByUser]];
}

- (IBAction)changeDirection:(id)sender
{
	[_propObject setDirection:[sender floatValue]];

}

- (IBAction)changeLayer:(id)sender
{
	[_propObject setLayer:[sender floatValue]];
}

- (IBAction)changeLifeTime:(id)sender
{
	[_propObject setLifeTime:[sender intValue]];
}

- (IBAction)changeSpeed:(id)sender
{
	[_propObject setSpeedModule:[sender floatValue]];
}

- (IBAction)changeX:(id)sender
{
	[_propObject setPos:NSMakePoint([sender floatValue],[_propObject pos].y)];
}

- (IBAction)changeY:(id)sender
{
	[_propObject setPos:NSMakePoint([_propObject pos].x,[sender floatValue])];
}

- (IBAction)switchContrByUser:(id)sender {
	[_propObject setControlledByUser:[sender state]];
}

- (IBAction)switchActive:(id)sender {
	[_propObject setActive:[sender state]];
}

@end
