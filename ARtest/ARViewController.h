//
//  ARViewController.h
//  ARtest
//
//  Created by admin on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ARViewController : UIViewController<CLLocationManagerDelegate,UIAccelerometerDelegate>{
    IBOutlet UILabel *label;
    IBOutlet UILabel *labelx;
    IBOutlet UIWebView *gifloader;
    IBOutlet UIWebView *mikuloader;
    CLLocationManager *gps;
    CGFloat gpshead;
    CGFloat posx;
    CGFloat posy;
    CGFloat scale;
    CGSize gifsize;
    int gifstartangle;
    int gifstarty;
    NSTimer *timer;
    CGFloat anglex;
    CGFloat angley;
    CGFloat accez;
    
    CGFloat mikux;
    CGFloat mikuanglex;
    int mikustart;
}

@end
