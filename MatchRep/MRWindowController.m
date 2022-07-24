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

@end
