//
//  MRWindowController.m
//  MatchRep
//
//  Created by Tom Houpt on 22/7/24.
//

#import "MRWindowController.h"

@interface MRWindowController ()

@end

@implementation MRWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    if (_pdfURL != nil) {
        [self displayPDF];
    }
    
}

-(void)displayPDF; {

    _pdf = [[PDFDocument alloc] initWithURL:_pdfURL];
    [_pdfView setDocument:_pdf];
    
    NSURL *nsurl=[NSURL URLWithString:@"https://pubmed.ncbi.nlm.nih.gov"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webView loadRequest:nsrequest];
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation; {

    [_textField setStringValue:[[webView URL] absoluteString]];
    
   NSString *pmidStr = [[_webView URL] lastPathComponent];
   
   NSError *error = NULL;
NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\b[0-9]+\\b"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:&error];

NSUInteger numberOfMatches = [regex numberOfMatchesInString:pmidStr
                                                    options:0
                                                      range:NSMakeRange(0, [pmidStr length])];


if ([pmidStr length] >= 7 && numberOfMatches == 1) {
    // this matches the criteria
    
    [_pmidField setStringValue:pmidStr];
    [_renameButton setEnabled:YES];
    
    
} else {

    [_renameButton setEnabled:NO];
}

}

-(IBAction)renamePDF:(id)sender; {

// get pmid from last element of [_textField setStringValue]
// replace last element of _pdfURL with lastElement of webView URL]
NSString *pmid =  [_pmidField stringValue];


NSString *pmidpdf = [pmid stringByAppendingString:@".pdf"];

NSURL *newURL = [[_pdfURL URLByDeletingLastPathComponent] URLByAppendingPathComponent: pmidpdf];


NSLog(@"New URL: %@",[newURL path]);

NSError *error = nil;
// source and destination are URLs
//if ([_pdfURL startAccessingSecurityScopedResource]) {
        [[NSFileManager defaultManager] moveItemAtURL:_pdfURL toURL:newURL error:&error];
       // copyItemAtURL or moveItemAtUrl throws a 513 error!
       // do turned off sandbocing in MatchRep.entitlements
       
       //try  https://tw.coderbridge.com/questions/cb9c272df6424692b3a25bbe7c152d81
       // [_pdfURL setResourceValue:pmidpdf forKey:NSURLNameKey error:&error];
        
//}
[_pdfURL stopAccessingSecurityScopedResource];


}

@end
