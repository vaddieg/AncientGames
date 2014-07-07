#import "ScoreWindowController.h"

@implementation ScoreWindowController

- (void)windowWillClose:(NSNotification *)aNotification
{
    [sourceScore writeToFile:scoreFile atomically:NO]; //saving scores to file
    //[sourceScore release];
}

- (IBAction)resetScores:(id)sender{
    int i;
    [sourceScore removeAllObjects];
    NSString* s=[NSString stringWithString:@"30:30Anonymous"]; //Default value
    for (i=0; i<3; i++) [sourceScore insertObject:[NSString stringWithString:s] atIndex:0];
    [scoreTable reloadData];
   }

- (void)initScores {
    scoreFile=[[[NSString stringWithString:@"~/Documents/minscores"] stringByExpandingTildeInPath]retain];
    
    sourceScore=[NSMutableArray arrayWithContentsOfFile:scoreFile]; //Trying to open score file
    if (sourceScore==nil) {
        sourceScore=[NSMutableArray array];
        [self resetScores:self];
    }
    [sourceScore retain];//keep array in ram
    //NSLog(@"Scores Initialized");
}


//Table view protocol mehods
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
 return [sourceScore count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex{
 NSParameterAssert(rowIndex >= 0 && rowIndex < [sourceScore count]);
 if ([[aTableColumn identifier] isEqual:@"Time"]) 
 return [[sourceScore objectAtIndex:rowIndex] substringToIndex:5]; else
 if ([[aTableColumn identifier] isEqual:@"Player"])
 return [[sourceScore objectAtIndex:rowIndex] substringFromIndex:5]; else 
    switch (rowIndex) {
    case 0: return @"Easy"; break;
    case 1: return @"Normal"; break;
    case 2: return @"Hard"; break;
    default: return @"Normal";
    }
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex{
  NSParameterAssert(rowIndex >= 0 && rowIndex < [sourceScore count]);
  NSMutableString* tmp=[NSMutableString stringWithString:[[sourceScore objectAtIndex:rowIndex] substringToIndex:5]];
  [tmp appendString:anObject]; 
  [sourceScore removeObjectAtIndex:rowIndex];
  [sourceScore insertObject:tmp atIndex:rowIndex];
 return; 
}

- (IBAction)closeScores:(id)sender{
    [self close];
}

- (BOOL)goodCandidateTime:(int)time forLevel:(int)gamLev{
    int curtime;
    NSString *ms, *ss;
    ms=[[sourceScore objectAtIndex:gamLev] substringWithRange:NSMakeRange(0,2)];
    ss=[[sourceScore objectAtIndex:gamLev] substringWithRange:NSMakeRange(3,2)];
    curtime=[ms intValue]*60+[ss intValue];
    if (time<curtime) return YES;
    else return NO;
}
- (void)addResult:(int)time:(int)gamLev:(NSString *)name
{
    int min,sec;
    min=time/60;
    sec=time%60;
    NSMutableString* rec=[NSMutableString stringWithFormat:@"%02d:%02d",min,sec];
    [rec appendString:name];
    [sourceScore replaceObjectAtIndex:gamLev withObject:rec];
}

@end
