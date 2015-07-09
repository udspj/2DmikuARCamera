//
//  ARViewController.m
//  ARtest
//
//  Created by admin on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ARViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation ARViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(loadgif)];
    [self performSelector:@selector(startgps)];
    [self performSelector:@selector(startacce)];
}
-(void)startacce{
    UIAccelerometer *acce = [UIAccelerometer sharedAccelerometer];
    acce.delegate = self;
    acce.updateInterval = 1.0f/60.0f;
}
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    accez = acceleration.z;
}

-(void)startgps{
    gps = [[CLLocationManager alloc] init];
    gps.delegate = self;
    gps.distanceFilter = 1000.0f;
    gps.desiredAccuracy = kCLLocationAccuracyBest;
    
    gifstartangle = 360;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changegifangle) userInfo:Nil repeats:YES];
    
    [gps startUpdatingHeading];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    gpshead = newHeading.magneticHeading;
    label.text = [NSString stringWithFormat:@"地理朝向：%f",newHeading.magneticHeading];
}
-(void)changegifangle{
    labelx.text = [NSString stringWithFormat:@"miku hourse position x：%f",posx];
    gifstartangle --;
    if (gifstartangle < 0) {//让草泥马跑起来
        gifstartangle = 360;
    }
    mikustart = 0;
    //gifstartangle = 250;
    gifstarty = 240;
    
    scale = 9;//根据AR物体模拟的距离来定
    if (gpshead < 180) {
        anglex = -gpshead + gifstartangle;
        mikuanglex = -gpshead + mikustart;
    }else{
        anglex = 360-gpshead + gifstartangle;
        mikuanglex = 360-gpshead + mikustart;
    }
    if (anglex > 360) {
        anglex -= 360;
    }
    if (anglex < 180) {
        posx = anglex * scale;
    }else{
        posx = (anglex - 360) * scale;
    }
    
    if (mikuanglex < 180) {//初音酱是固定在朝向角度0方向的，可以随意调
        mikux = mikuanglex * scale;
    }else{
        mikux = (mikuanglex - 360) * scale;
    }
    
    angley = 240 * accez * 2;//“2”这个修正值也是根据AR物体模拟的距离来定
    
    [gifloader setFrame:CGRectMake(posx, angley, gifsize.width, gifsize.height)];
    [mikuloader setFrame:CGRectMake(mikux, angley + 100, gifsize.width, gifsize.height)];
}

-(void)loadgif{
    NSData *gifdata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yt" ofType:@"gif"]];
    CGRect gifframe = CGRectMake(0, 0, 0, 0);
    gifsize = [UIImage imageNamed:@"yt.gif"].size;
    gifframe.size = gifsize;
    [gifloader setFrame:gifframe];
    gifloader.backgroundColor = [UIColor clearColor];
    gifloader.opaque = NO;
    [gifloader loadData:gifdata MIMEType:@"image/gif" textEncodingName:Nil baseURL:Nil];
    
    gifdata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"miku" ofType:@"gif"]];
    gifsize = [UIImage imageNamed:@"miku.gif"].size;
    gifframe.size = gifsize;
    [mikuloader setFrame:gifframe];
    mikuloader.backgroundColor = [UIColor clearColor];
    mikuloader.opaque = NO;
    [mikuloader loadData:gifdata MIMEType:@"image/gif" textEncodingName:Nil baseURL:Nil];
}





- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
