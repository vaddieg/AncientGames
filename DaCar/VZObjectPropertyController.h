/* VZObjectPropertyController */
// base class for object property controller 


#import <Cocoa/Cocoa.h>
@class VZActiveObject;

@interface VZObjectPropertyController : NSObject
{
    VZActiveObject *_propObject;
    IBOutlet NSView *_view;
    IBOutlet NSButton *activeSwitch;
    IBOutlet NSTextField *dirField;
    IBOutlet NSTextField *layField;
    IBOutlet NSTextField *lifeField;
    IBOutlet NSTextField *spField;
    IBOutlet NSButton *userSwitch;
    IBOutlet NSTextField *xField;
    IBOutlet NSTextField *yField;
	BOOL _nibLoaded;
}
- (id)initForObject:(VZActiveObject*)obj;
- (NSString*)propertyNibName;
- (void)loadNibIfNeed;
- (NSView*)view;
- (void)updateControls;

- (IBAction)changeDirection:(id)sender;
- (IBAction)changeLayer:(id)sender;
- (IBAction)changeLifeTime:(id)sender;
- (IBAction)changeSpeed:(id)sender;
- (IBAction)changeX:(id)sender;
- (IBAction)changeY:(id)sender;
- (IBAction)switchContrByUser:(id)sender;
- (IBAction)switchActive:(id)sender;

@end
