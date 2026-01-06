#import <UIKit/UIKit.h>
#import <dispatch/dispatch.h>

static UIView *harkSplashView = nil;

static UIWindow *HarkFindActiveWindow(void) {
  UIWindow *targetWindow = nil;
  if (@available(iOS 13.0, *)) {
    NSSet<UIScene *> *connectedScenes = UIApplication.sharedApplication.connectedScenes;
    for (UIScene *scene in connectedScenes) {
      if (scene.activationState != UISceneActivationStateForegroundActive &&
          scene.activationState != UISceneActivationStateForegroundInactive) {
        continue;
      }
      if (![scene isKindOfClass:[UIWindowScene class]]) {
        continue;
      }
      UIWindowScene *windowScene = (UIWindowScene *)scene;
      for (UIWindow *window in windowScene.windows) {
        if (window.isHidden) {
          continue;
        }
        if (window.isKeyWindow) {
          return window;
        }
        if (targetWindow == nil) {
          targetWindow = window;
        }
      }
    }
  }
  return targetWindow;
}

static void HarkEnsureSplashView(void) {
  UIWindow *window = HarkFindActiveWindow();
  if (window == nil) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(16 * NSEC_PER_MSEC)),
                   dispatch_get_main_queue(), ^{
                     HarkEnsureSplashView();
                   });
    return;
  }

  if (harkSplashView != nil) {
    if (harkSplashView.superview != window) {
      [harkSplashView removeFromSuperview];
      harkSplashView.frame = window.bounds;
      [window addSubview:harkSplashView];
    }
    return;
  }

  UIImage *image = [UIImage imageNamed:@"LaunchImage"];
  if (image == nil) {
    image = [UIImage imageNamed:@"Mobile/2"];
  }

  UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
  imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.backgroundColor = UIColor.whiteColor;
  imageView.image = image;
  imageView.accessibilityIdentifier = @"hark.native.splash";

  harkSplashView = imageView;
  [window addSubview:harkSplashView];
}

static void HarkShowSplashView(void) {
  HarkEnsureSplashView();
  if (harkSplashView == nil) {
    return;
  }
  harkSplashView.alpha = 1.0;
  harkSplashView.hidden = NO;
}

static void HarkHideSplashView(void) {
  if (harkSplashView == nil) {
    return;
  }
  [UIView animateWithDuration:0.35
                        delay:0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     harkSplashView.alpha = 0.0;
                   }
                   completion:^(BOOL finished) {
                     (void)finished;
                     [harkSplashView removeFromSuperview];
                     harkSplashView = nil;
                   }];
}

#ifdef __cplusplus
extern "C" {
#endif

void hark_show_splashscreen(void) {
  dispatch_async(dispatch_get_main_queue(), ^{
    HarkShowSplashView();
  });
}

void hark_hide_splashscreen(void) {
  dispatch_async(dispatch_get_main_queue(), ^{
    HarkHideSplashView();
  });
}

#ifdef __cplusplus
}
#endif
