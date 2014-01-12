// Capture an image from an iSight camera from the command line.
//
// Written by Ron Garret, July 2008.  This code is hereby placed in
// the public domain.
//
// This is a proof-of-concept and could stand a lot of tweaking.
// File names, camera selection, and other parameters are hard-coded.
// Synchronization is done with a spinlock.  If you make improvements
// to this code I'd appreciate getting a copy.
//
// Compile with:
// gcc -o qt-capture -framework Foundation -framework QTKit
//              -framework Cocoa qt-capture.m

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface myThread:NSThread {
  int cnt;
}
@end

@implementation myThread:NSThread

- (CIImage *)view:(QTCaptureView *)view willDisplayImage :(CIImage *)image {
  if (cnt==0) {
    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithCIImage:image];

    NSData *imgData = [bitmap representationUsingType:NSJPEGFileType
          properties:[NSDictionary
                       dictionaryWithObject:[NSNumber numberWithFloat:0.9]
                       forKey:NSImageCompressionFactor]];

    fwrite([imgData bytes], [imgData length], 1, stdout);
  } else {
    NSLog(@"Captured %d extra frames", cnt);
  }
  cnt++;
  [NSApp terminate:self];
  return image;
}

- (void)main {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  NSArray *a = [QTCaptureDevice inputDevicesWithMediaType:QTMediaTypeVideo];
  QTCaptureDevice *cam = [a objectAtIndex:0];
  NSError *err;
  if ([cam open:&err] != YES) {
    NSLog(@"Error opening camera: %@", err);
  }
  QTCaptureDeviceInput *in = [[QTCaptureDeviceInput alloc] initWithDevice:cam];
  QTCaptureSession *session = [[QTCaptureSession alloc] init];
  if ([session addInput:in error:&err] != YES) {
    NSLog(@"Error adding input to capture session: %@", err);
  }
  QTCaptureView *v = [[QTCaptureView alloc] init];
  [v setCaptureSession:session];
  [v setDelegate:self];

  NSWindow *win = [[NSWindow alloc] initWithContentRect:NSMakeRect
                                    (50, 50, 1080, 720)
                                    styleMask:15
                                    backing:NSBackingStoreBuffered
                                    defer:NO];
  [win setContentView:v];
  NSLog(@"Capturing from %@", cam);
  [session startRunning];
  while(1) sleep(1000);
  [pool release];
}

@end


int main( int argc, const char* argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  [NSApplication sharedApplication];
  [[[myThread alloc] init] start];
  [NSApp run];
  [pool release];
  return 0;
}

