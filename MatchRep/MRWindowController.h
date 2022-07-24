//
//  MRWindowController.h
//  MatchRep
//
//  Created by Tom Houpt on 22/7/24.
//

#import <Cocoa/Cocoa.h>
#import <PDFKit/PDFKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRWindowController : NSWindowController

@property NSURL *pdfURL;
@property PDFDocument *pdf;
@property IBOutlet PDFView *pdfView;
@property IBOutlet WKWebView *webView;

-(void)displayPDF;

@end

NS_ASSUME_NONNULL_END
