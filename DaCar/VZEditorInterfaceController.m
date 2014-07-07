#import "VZEditorInterfaceController.h"
#import "VZObjectPropertyController.h"
#import "VZSceneDocument.h"
#import "VZActiveObject.h"


@implementation VZEditorInterfaceController


-(void)dealloc {
	if (_cc) [[_cc view] removeFromSuperview];
	[_cc release];
	NSLog(@"ic deallc");
	[super dealloc];
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView {
	return [[_doc objectsList] count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row {
	if ([[tableColumn identifier] isEqual:@"Class"]) return NSStringFromClass([[[_doc objectsList] objectAtIndex:row] class]);
	else return [[[_doc objectsList] objectAtIndex:row] description];
}
-(void)fillClassesPopUp {
	NSString* butTitle = [NSString stringWithString:[[classesPopUp itemAtIndex:0] title]];
	[classesPopUp removeAllItems];
	
	[classesPopUp addItemWithTitle:butTitle];
	int i;
	for (i=0; i<[[VZGameObject allSubclasses] count]; i++)
		[classesPopUp addItemWithTitle:NSStringFromClass([[VZGameObject allSubclasses] objectAtIndex:i])];
	
}
-(void)awakeFromNib {
	NSLog(@"IC NIB awwake");
	NSLog([[VZGameObject allSubclasses] description]);
	[self fillClassesPopUp];
	//tempo
	/*VZActiveObject* obj=[VZActiveObject new];
	NSLog([obj propertyControllerClass]);
	Class cl=NSClassFromString([obj propertyControllerClass]);
	_cc=[[cl alloc] initForObject:obj];
	[objectPropertyView addSubview:[_cc view]];
	[_cc updateControls];*/
}
-(NSView*)objectView {
	return objectPropertyView;
}

-(NSView*)sceneView {
	return scenePropertyView;
}


- (IBAction)addObject:(id)sender
{
	NSLog(@"add obj to scene");
	int indx=[sender indexOfSelectedItem]-1; // Button title at 0 
	[_doc addGameObjectOfClass:[[VZGameObject allSubclasses] objectAtIndex:indx]];
	[objectListTable reloadData];
}

- (IBAction)removeObject:(id)sender
{
	int indx=[objectListTable selectedRow];
	if (indx<0) return;
	[_doc removeGameObjectAtIndex:indx];
	[objectListTable reloadData];
}

- (IBAction)selectObject:(id)sender
{
	//if ([sender clickedRow] == [sender selectedRow]) return;
	int indx=[sender selectedRow];
	if (indx<0) return;
	VZActiveObject* obj = [[_doc objectsList] objectAtIndex:indx];
	Class controllerClass = NSClassFromString([obj propertyControllerClass]);
	[[_cc view] removeFromSuperview];
	[_cc release];
	_cc = [[controllerClass alloc] initForObject:obj];
	[objectPropertyView addSubview:[_cc view]];
	[_cc updateControls];
	//[self setPropertyController:];
} 
- (IBAction)startScene:(id)sender {
	float val=[fpsField floatValue];
	if (val<1)
		[_doc startSceneWithFps:5];
	else [_doc startSceneWithFps:val];

}

@end
