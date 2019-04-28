#import "Tweak.h"
#import <libcolorpicker.h>
#import <objc/runtime.h>

static UIColor *headercolor, *textcolor;


static void sendNotification() 
{
    // Thanks to d4ni (NotificationTester)
    // https://git.d4ni.nl/daniwinter/NotificationTester/
    [[objc_getClass("JBBulletinManager") sharedInstance] showBulletinWithTitle:@"NotifyHeaders"
                                                           message:@"This is a test notification"
                                                           bundleID:@"com.apple.Preferences"];
}

static void initPrefs()
{
    NSString *prefsPath = @"/User/Library/Preferences/com.shepgoba.notifyheaders.plist";
    NSString *prefsDefault = @"/Library/PreferenceBundles/notifyheaders.bundle/defaults.plist";
    

    NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (![fileManager fileExistsAtPath:prefsPath]) {
		[fileManager copyItemAtPath:prefsDefault toPath:prefsPath error:nil];
	}

}

static void updatePrefs()
{

    NSString *colorPrefsPath = @"/User/Library/Preferences/com.shepgoba.notifyheaderscolors.plist";
    NSMutableDictionary *colorPrefs = [[NSMutableDictionary alloc] initWithContentsOfFile:colorPrefsPath];

    if (colorPrefs)
    {
        headercolor = LCPParseColorString([colorPrefs objectForKey:@"headerColor"], @"#FFFFFF");
        textcolor = LCPParseColorString([colorPrefs objectForKey:@"textColor"], @"#000000");
    }
    
    [colorPrefs release];
}

%group NotifyHeaders
    %hook NCNotificationShortLookView
        -(void) _configureNotificationContentViewIfNecessary
        {
            updatePrefs();
            %orig;
            MTPlatterHeaderContentView *headerContentView = [self _headerContentView];

            // thanks to skittyblock (Dune)
            // https://github.com/Skittyblock/Dune/blob/master/Tweak.xm
            [[[headerContentView _titleLabel] layer] setFilters:nil];
            [[[headerContentView _dateLabel] layer] setFilters:nil];
            [[headerContentView _titleLabel] setTextColor:textcolor];
            [[headerContentView _dateLabel] setTextColor:textcolor];


            // Set header background color
            headerContentView.backgroundColor = headercolor;

            //Set corner radius and shorten frame height
            CAShapeLayer *submaskLayer = [[CAShapeLayer alloc] init];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(headerContentView.frame.origin.x, headerContentView.frame.origin.y, headerContentView.frame.size.width, headerContentView.frame.size.height - 5) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(12, 12)];
            submaskLayer.frame = CGRectMake(headerContentView.frame.origin.x, headerContentView.frame.origin.y, headerContentView.frame.size.width, headerContentView.frame.size.height - 5);
            submaskLayer.path  = maskPath.CGPath;

            headerContentView.layer.mask = submaskLayer;
        }
    %end
%end



%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)sendNotification, CFSTR("com.shepgoba.notifyheaders/notificationBanner"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    
    initPrefs();
    updatePrefs();
    %init(NotifyHeaders);
}





