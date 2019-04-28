#include "NotifyHeaders.h"
//#import <spawn.h>
@implementation NHPRootListController

- (void)viewWillAppear:(BOOL)animated {
    /*[super viewWillAppear:animated];
   	UIBarButtonItem *testButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(respringDevice)];
    self.navigationItem.rightBarButtonItem = testButton;*/
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
-(void) sendBanner
{
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.shepgoba.notifyheaders/notificationBanner"), nil, nil, true);
}
/*
-(void) respringDevice {
	pid_t pid;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}*/
- (void) openPaypal
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/shepgobadev"]];
}

- (void) openTwitter
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/shepgoba"]];
}

@end
