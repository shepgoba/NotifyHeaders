@interface JBBulletinManager : NSObject
+(id)sharedInstance;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID;
@end

@interface MTPlatterHeaderContentView : UIView
-(UILabel *) _dateLabel;
-(UILabel *) _titleLabel;
@end

@interface NCNotificationShortLookView : UIView
-(MTPlatterHeaderContentView *)_headerContentView;
@end