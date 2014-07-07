/* VZEditorInterfaceController */

#import <Cocoa/Cocoa.h>

@class VZSceneDocument;
@class VZObjectPropertyController;


@interface VZEditorInterfaceController : NSWindowController
{
    IBOutlet NSTableView *objectListTable;
    IBOutlet NSView *objectPropertyView;
    IBOutlet NSView *scenePropertyView;
	IBOutlet VZSceneDocument *_doc;
	IBOutlet NSPopUpButton *classesPopUp;
	IBOutlet NSTextField *fpsField;
	//IBOutlet NSView* _sceneView;
	//tempo
	VZObjectPropertyController *_cc; //current controller
}
// table view datasource
- (int)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row;
//-(void)setObjectSubview:(NSView*)view;
-(NSView*)objectView;
//-(void)setSceneSubview:(NSView*)view;
-(NSView*)sceneView;

- (IBAction)addObject:(id)sender;
- (IBAction)removeObject:(id)sender;
- (IBAction)selectObject:(id)sender;
- (IBAction)startScene:(id)sender;


@end
