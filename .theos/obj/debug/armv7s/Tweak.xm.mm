#line 1 "Tweak.xm"
#import "Tweak.h"
#import <libcolorpicker.h>
#import <objc/runtime.h>

static UIColor *headercolor, *textcolor;

static void sendNotification() {
    
    
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class NCNotificationShortLookView; 


#line 53 "Tweak.xm"
static void (*_logos_orig$NotifyHeaders$NCNotificationShortLookView$_configureNotificationContentViewIfNecessary)(_LOGOS_SELF_TYPE_NORMAL NCNotificationShortLookView* _LOGOS_SELF_CONST, SEL); static void _logos_method$NotifyHeaders$NCNotificationShortLookView$_configureNotificationContentViewIfNecessary(_LOGOS_SELF_TYPE_NORMAL NCNotificationShortLookView* _LOGOS_SELF_CONST, SEL); 
    

        static void _logos_method$NotifyHeaders$NCNotificationShortLookView$_configureNotificationContentViewIfNecessary(_LOGOS_SELF_TYPE_NORMAL NCNotificationShortLookView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
            updatePrefs();
            _logos_orig$NotifyHeaders$NCNotificationShortLookView$_configureNotificationContentViewIfNecessary(self, _cmd);
            MTPlatterHeaderContentView *headerContentView = [self _headerContentView];

            
            
            [[[headerContentView _titleLabel] layer] setFilters:nil];
            [[[headerContentView _dateLabel] layer] setFilters:nil];
            [[headerContentView _titleLabel] setTextColor:textcolor];
            [[headerContentView _dateLabel] setTextColor:textcolor];


            
            headerContentView.backgroundColor = headercolor;

            
            CAShapeLayer *submaskLayer = [[CAShapeLayer alloc] init];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(headerContentView.frame.origin.x, headerContentView.frame.origin.y, headerContentView.frame.size.width, headerContentView.frame.size.height - 5) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(12, 12)];
            submaskLayer.frame = CGRectMake(headerContentView.frame.origin.x, headerContentView.frame.origin.y, headerContentView.frame.size.width, headerContentView.frame.size.height - 5);
            submaskLayer.path  = maskPath.CGPath;

            headerContentView.layer.mask = submaskLayer;
        }
    




static __attribute__((constructor)) void _logosLocalCtor_0a0f3d2f(int __unused argc, char __unused **argv, char __unused **envp) 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)sendNotification, CFSTR("com.shepgoba.notifyheaders/notificationBanner"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    
    
    initPrefs();
    updatePrefs();
    {Class _logos_class$NotifyHeaders$NCNotificationShortLookView = objc_getClass("NCNotificationShortLookView"); MSHookMessageEx(_logos_class$NotifyHeaders$NCNotificationShortLookView, @selector(_configureNotificationContentViewIfNecessary), (IMP)&_logos_method$NotifyHeaders$NCNotificationShortLookView$_configureNotificationContentViewIfNecessary, (IMP*)&_logos_orig$NotifyHeaders$NCNotificationShortLookView$_configureNotificationContentViewIfNecessary);}
}





