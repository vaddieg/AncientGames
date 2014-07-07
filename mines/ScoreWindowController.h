/* ScoreWindowController */

#import <Cocoa/Cocoa.h>

@interface ScoreWindowController : NSWindowController
{
    IBOutlet NSTableView *scoreTable;	//Table view
    NSMutableArray *sourceScore;	//Container
    NSString *scoreFile;		//File name and path
    
}
//Table view necessary methods
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex;
- (void)tableView:(NSTableView *)aTableView setObjectValue:anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex;
- (int)numberOfRowsInTableView:(NSTableView *)aTableView;

- (IBAction)closeScores:(id)sender;		//OK button
- (IBAction)resetScores:(id)sender;		//Reset baton
- (BOOL)goodCandidateTime:(int)time forLevel:(int)gamLev; //Return YES if game time can be placed in table
- (void)addResult:(int)time:(int)gamLev:(NSString *)name;
- (void)initScores;				// Read scores from file, or creating default
@end
