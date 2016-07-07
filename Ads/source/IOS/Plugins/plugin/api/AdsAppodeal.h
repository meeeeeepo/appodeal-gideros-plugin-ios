//
//  AdsAdmob.h
//  Ads
//
//  Created by Arturs Sosins on 6/25/13.
//  Copyright (c) 2013 Gideros Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdsProtocol.h"
#import "AdsManager.h"
#import <Appodeal/Appodeal.h>

@interface AdsAppodeal : NSObject <AdsProtocol,AppodealNativeAdServiceDelegate,AppodealNativeAdDelegate>

@property (nonatomic, retain) NSString *appKey;
@property (nonatomic, retain) AdsManager *mngr;

@property (nonatomic, strong) AppodealNativeAdViewAttributes* attributes;
@property (nonatomic, strong) AppodealNativeAdService* adService;
@property (nonatomic, strong) AppodealNativeAd* ad;
@property (nonatomic, strong) AppodealNativeAdView* adView;
@property (nonatomic, strong) UIView* myView;
@property (nonatomic) NSInteger adViewType;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@end

@interface AdsAppodealListener : NSObject<AppodealBannerDelegate, AppodealInterstitialDelegate, AppodealVideoDelegate,AppodealRewardedVideoDelegate>

@property (nonatomic, retain) AdsState *state;
@property (nonatomic, retain) AdsAppodeal *instance;
-(id)init:(AdsState*)state with:(AdsAppodeal*)instance;

@end