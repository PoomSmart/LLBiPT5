%hook AVCaptureDevice

- (BOOL)automaticallyEnablesLowLightBoostWhenAvailable { return YES; }

- (BOOL)isLowLightBoostSupported { return YES; }

- (void)setAutomaticallyEnablesLowLightBoostWhenAvailable:(BOOL)available {
  NSError *error = nil;
  if (![self lockForConfiguration]) {
       NSLog(@"LLBiPT5: Failed to enable automatic Low-light Boost mode.");
       return;
  }
  objc_msgSend(self, @selector(setAutomaticallyEnablesLowLightBoostWhenAvailable:), available);
  [self unlockForConfiguration];
}

%end

%hook AVCaptureDeviceFormat

- (BOOL)supportsLowLightBoost {	return YES; }

%end

%hook AVCaptureFigVideoDevice

- (BOOL)isLowLightBoostSupported { return YES; }

%end
