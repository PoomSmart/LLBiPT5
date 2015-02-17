#import "../PS.h"

CFStringRef const PreferencesNotification = CFSTR("com.PS.LLBiPT5.prefs");
NSString *const PREF_PATH = @"/var/mobile/Library/Preferences/com.PS.LLBiPT5.plist";

BOOL LLB;

%group Group1

%hook AVCaptureDevice

- (BOOL)automaticallyEnablesLowLightBoostWhenAvailable
{
	return LLB;
}

- (BOOL)isLowLightBoostSupported
{
	return LLB;
}

%end

%hook AVCaptureDeviceFormat

- (BOOL)supportsLowLightBoost
{
	return LLB;
}

%end

%hook AVCaptureFigVideoDevice

- (BOOL)isLowLightBoostSupported
{
	return LLB;
}

%end

%end

%group Group2

%hook AVCaptureDeviceFormat_FigRecorder

- (BOOL)supportsLowLightBoost
{
	return LLB;
}

%end

%hook AVCaptureFigVideoDevice_FigRecorder

- (BOOL)isLowLightBoostSupported
{
	return LLB;
}

%end

%hook FigCaptureSourceFormat

- (BOOL)isVideoLowLightBinningSwitchSupported
{
	return LLB;
}

%end

%end

static void reloadSettings()
{
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
	CFPreferencesAppSynchronize(CFSTR("com.PS.LLBiPT5"));
	LLB = prefs[@"LLB"] ? [prefs[@"LLB"] boolValue] : YES;
}

static void post(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	system("killall Camera");
	if (isiOS8Up)
		system("killall mediaserverd");
	reloadSettings();
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &post, PreferencesNotification, NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadSettings();
	if (isiOS8Up) {
		%init(Group2);
	}
	%init(Group1);
	[pool drain];
}
