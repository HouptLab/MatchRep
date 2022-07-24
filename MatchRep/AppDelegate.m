//
//  AppDelegate.m
//  MatchRep
//
//  Created by Tom Houpt on 22/7/24.
//

#import "AppDelegate.h"
#import "MRWindowController.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet MRWindowController *windowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self openPDF:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender; {

    return YES;
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

-(IBAction)openPDF:(id)sender; {

 NSOpenPanel* panel = [NSOpenPanel openPanel];

    [panel setTitle:@"Match 2 Repository"];
    
     [panel setMessage:@"Choose a PDF File"];
    

    [panel setAllowedFileTypes:@[@"pdf",@"PDF"]];
 
   // This method displays the panel and returns immediately.
   // The completion handler is called when the user selects an
   // item or cancels the panel.
   [panel beginWithCompletionHandler:^(NSInteger result){
       if (result == NSModalResponseOK) {
         NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
 
         // Open  the document.
           [self->_windowController setPdfURL:theDoc];
           [self->_windowController displayPDF];
      }
 
   }];

}

@end
