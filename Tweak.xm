%hook AVCaptureDevice

- (BOOL)automaticallyEnablesLowLightBoostWhenAvailable { return YES; }

%end

%hook AVCaptureDeviceFormat

- (BOOL)supportsLowLightBoost { return YES; }

%end

%hook AVCaptureFigVideoDevice

- (BOOL)isLowLightBoostSupported { return YES; }

%end
