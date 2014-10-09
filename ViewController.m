/*
 The Likeness, Logos and text of this app are provided as reference and may not be reproduced in a derivative work
 Copyright 2014 SnoopWall LLC
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ViewController ()

@end

@implementation ViewController
CGFloat defaultBrightness;
int valBackLight;
AppDelegate *me;



BOOL LEDgo;
BOOL LEDon;
NSTimer *t;
UIStatusBarStyle curBar;
CAGradientLayer *bkgrd;
- (void)viewDidLoad {
    [super viewDidLoad];
    valBackLight = 0;
    me = [[UIApplication sharedApplication] delegate];
    me.myViewController = self;
    bkgrd = [self greyGradient];
    bkgrd.frame = self.view.bounds;
    _bBtn.titleLabel.font = [UIFont fontWithName:@"SNOOPICON" size:84];
    _bBtn.layer.cornerRadius = _bBtn.bounds.size.width / 2.0;
    _bBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self btnOff:_bBtn];
    _aBtn.titleLabel.font = [UIFont fontWithName:@"SNOOPICON" size:84];
    _aBtn.layer.cornerRadius = _aBtn.bounds.size.width / 2.0;
    _aBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    _bBtn.autoresizingMask =_aBtn.autoresizingMask = UIViewAutoresizingNone;
    [self btnOff:_aBtn];
    
    
    LEDon = NO;
    
    LEDgo = [self hasLED];
    
    if(!LEDgo){
        [_aBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    _warnText.layer.borderWidth = 1;
    _warnText.layer.cornerRadius = 15;
    _warnText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _warnText.layer.borderColor = [UIColor blackColor].CGColor;
    [_warnText setHidden:YES];
    [self.view.layer insertSublayer:bkgrd atIndex:0];
    t = nil;
    curBar = UIStatusBarStyleLightContent;
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    //[self.view.layer insertSublayer:[self greyGradient] atIndex:0];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)doUrl:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.snoopwall.com"]];
}
- (void) showWarning{
    _warnText.alpha = 1;
    [_warnText setHidden:NO];
    if (t != nil) {
        [t invalidate];
        t=nil;
    }
    t = [NSTimer scheduledTimerWithTimeInterval:(0.5)
                                         target:self
                                       selector:@selector(hideWarning)
                                       userInfo:nil
         
                                        repeats:NO];
    
}
- (void) hideWarning{
    [UIView animateWithDuration:3.0 animations:^{
        _warnText.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished){
            [_warnText setHidden:YES];
            [t invalidate];
            t=nil;
        }
        
        
    }];
}
- (void)doLayout{
    CGFloat w =  self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    CGFloat _w;
    CGFloat _h;
    CGFloat __w;
    CGFloat __h;
    CGFloat _x;
    CGFloat _y;
    CGRect _tmp;
    // place btm txt
    _w = _urlText.frame.size.width;
    _h = _urlText.frame.size.height;
    _tmp = _urlText.frame;
    _tmp.origin.y = h - (_h+10.0f);
    _tmp.origin.x = (w*0.5f)-(_w*0.5f);
    _urlText.frame = _tmp;
    __h = (_h+10.0f);
    ////
    
    // place logo
    _w = _logoImg.frame.size.width;
    _h = _logoImg.frame.size.height;
    _tmp = _logoImg.frame;
    _tmp.origin.y = h - __h - (_h+10.0f);
    _tmp.origin.x = (w*0.5f)-(_w*0.5f);
    _logoImg.frame = _tmp;
    
    //
    
    //place top text
    _w = _topText1.frame.size.width;
    _h = _topText1.frame.size.height;
    __w = _topText2.frame.size.width;
    __h = _topText2.frame.size.height;
    _tmp = _topText1.frame;
    _tmp.origin.y = 35.0f;
    _x = _tmp.origin.x = (w*0.5f)-((_w + __w + 5.0f)*0.5f);
    _topText1.frame = _tmp;
    _tmp = _topText2.frame;
    
    _tmp.origin.y = ABS(_h-__h)*0.5+35.0f;
    _tmp.origin.x = _x + _w + 5.0f;
    _topText2.frame = _tmp;
    __h = MAX(_h, __h);
    ///
    
    /// place btns
    _w = _aBtn.frame.size.width*2 + _logoImg.frame.size.width + 10.0f;
    _tmp = _aBtn.frame;
    _x = _tmp.origin.x = (w*0.5f) - (_w*0.5f);
    _y = _tmp.origin.y = __h + 55.0f;
    _aBtn.frame = _tmp;
    
    _tmp = _bBtn.frame;
    
    _tmp.origin.y = _y;
    _tmp.origin.x = _x + _tmp.size.width +10.0f + _logoImg.frame.size.width;
    _bBtn.frame = _tmp;
    ///
    
    // warn text
    _w = _warnText.frame.size.width;
    _h = _warnText.frame.size.height;
    _tmp = _warnText.frame;
    _tmp.origin.y = (h*0.5f) - (_h*0.5f);
    _tmp.origin.x
    = (w*0.5f) - (_w*0.5f);
    _warnText.frame = _tmp;
    
    ///
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return curBar;
}
- (void) doScaleing{
    CGFloat w =  self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    CGFloat _w = MIN(w, h);
    if (!(_w - 45.0f < _topText1.frame.size.width + _topText2.frame.size.width)) return;
    CGFloat x;
    
    x = (_w - 45.0f)/(_topText1.frame.size.width + _topText2.frame.size.width);

    //scale top text;
    _topText1.contentScaleFactor *= x;
    _topText2.contentScaleFactor *= x;
    _topText1.transform = CGAffineTransformScale(_topText1.transform, x, x);
    _topText2.transform = CGAffineTransformScale(_topText2.transform, x, x);
    
    //
    
    // btns
    _aBtn.contentScaleFactor *= x;
    _bBtn.contentScaleFactor *= x;
    _aBtn.transform = CGAffineTransformScale(_aBtn.transform, x, x);
    _bBtn.transform = CGAffineTransformScale(_bBtn.transform, x, x);
   
    
    
    // logo img
    _logoImg.contentScaleFactor *= x;
    _logoImg.transform = CGAffineTransformScale(_logoImg.transform, x, x);
    //
    
    //url txt;
    _urlText.contentScaleFactor *= x;
    _urlText.transform = CGAffineTransformScale(_urlText.transform, x, x);
    _warnText.contentScaleFactor *= x;
    _warnText.transform = CGAffineTransformScale(_urlText.transform, x, x);
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    [me initBrightness];
    [self doScaleing];
    [self doLayout];
    // resize your layers based on the view’s new bounds
    [bkgrd setFrame:self.view.bounds];
    [super viewDidAppear:animated];
}
-(BOOL) hasLED{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

        return ([device hasTorch] && [device hasFlash]);
    }
    return NO;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self doLayout];
    // resize your layers based on the view’s new bounds
    [bkgrd setFrame:self.view.bounds];
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackLightClick:(id)sender {
    
    [self toggleBacklight];

}
- (void) toggleLED{
    LEDon = ~LEDon;
    if(LEDon){
        [self btnOn:_aBtn];
        [self turnLEDON];
    } else{
        [self btnOff:_aBtn];
        [self tunLEDOFF];
    }
}

-(void) tunLEDOFF{
    if (!LEDgo) return;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOff];
    [device setFlashMode:AVCaptureFlashModeOff];
    [device unlockForConfiguration];
    
}
-(void) turnLEDON{
    if (!LEDgo) return;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device setFlashMode:AVCaptureFlashModeOn];
    [device unlockForConfiguration];
}
- (IBAction)LEDClick:(id)sender {
    if(!LEDgo) {
        [self showWarning];
    } else{
        
        [self toggleLED];
    }

    
    
    
}
- (void) reset{
    valBackLight = 0;
    LEDon = 0;
    if(t != nil) {
        
        [t invalidate];
        t = nil;
    }
    [_warnText setHidden:YES];
    [self makeBlack];
    [self btnOff:_bBtn];
    [self btnOff:_aBtn];
    [_topText1 setTextColor:[UIColor whiteColor]];
    [_topText2 setTextColor:[UIColor whiteColor]];
    [_urlText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self tunLEDOFF];
}
- (void) btnOn:(UIButton *)x{
    x.layer.borderWidth = 2;
    x.layer.borderColor = [UIColor colorWithRed:0 green:0.682 blue:0.937 alpha:1].CGColor; /*#00aeef*/
}
- (void) btnOff:(UIButton *)x{
    x.layer.borderWidth = 1;
    x.layer.borderColor = [UIColor blackColor].CGColor;
}
- (void) makeWhite{
    [_topText1 setTextColor:[UIColor blackColor]];
    [_topText2 setTextColor:[UIColor blackColor]];
    [_urlText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    curBar = UIStatusBarStyleDefault;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    if ([[self.view.layer sublayers] objectAtIndex:0] ==  bkgrd) {
        [bkgrd removeFromSuperlayer];
    }
}
- (void) makeBlack{
    [_topText1 setTextColor:[UIColor whiteColor]];
    [_topText2 setTextColor:[UIColor whiteColor]];
    [_urlText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    curBar = UIStatusBarStyleLightContent;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    if ([[self.view.layer sublayers] objectAtIndex:0] !=  bkgrd) {
        [self.view.layer insertSublayer:bkgrd atIndex:0];
    }
    
}
- (CAGradientLayer*) greyGradient {
    /*
     android:type="linear"
     android:centerX="50%"
     android:startColor="#FF000000"
     android:centerColor="#FF525252"
     android:endColor="#FF000000"
     android:angle="180" />
     */
    UIColor *colorOne   = [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; /*#000000*/
    UIColor *colorTwo   = [UIColor colorWithRed:0.322 green:0.322 blue:0.322 alpha:1]; /*#525252*/
    UIColor *colorThree = [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; /*#000000*/
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.5];
    NSNumber *stopThree     = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, nil];
    CAGradientLayer *gr = [CAGradientLayer layer];
    gr.startPoint = CGPointMake(0, 0.5);
    gr.endPoint = CGPointMake(1.0, 0.5);
    gr.colors = colors;
    gr.locations = locations;
    
    return gr;
    
}
- (void)toggleBacklight{
    valBackLight = ~valBackLight;
    if(valBackLight){
        [self makeWhite];
        [self btnOn:_bBtn];
        [[UIScreen mainScreen] setBrightness:1.0];
    } else{
        [self makeBlack];
        [self btnOff:_bBtn];
        [me setDefault];
    }
}
@end
