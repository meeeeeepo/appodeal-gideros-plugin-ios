//
//  AdsAppodeal.m
//  AppodealGiderosSample
//
//  Created by ewgenius on 09/09/15.
//  Copyright (c) 2015 Gideros Mobile. All rights reserved.
//

#include "gideros.h"
#import "AdsAppodeal.h"
#import "AdsClass.h"

const int INTERSTITIAL  = 1;
const int VIDEO         = 2;
const int BANNER        = 4;
const int BANNER_BOTTOM = 8;
const int BANNER_TOP    = 16;
const int BANNER_CENTER = 32;
const int ALL           = 127;
const int ANY           = 127;

int nativeAdTypesForType(int adTypes) {
    int nativeAdTypes = 0;

    if ((adTypes & INTERSTITIAL) > 0) {
        nativeAdTypes |= AppodealAdTypeInterstitial;
    }

    if ((adTypes & VIDEO) > 0) {
        nativeAdTypes |= AppodealAdTypeSkippableVideo;
    }

    if ((adTypes & BANNER) > 0 ||
        (adTypes & BANNER_TOP) > 0 ||
        (adTypes & BANNER_CENTER) > 0 ||
        (adTypes & BANNER_BOTTOM) > 0) {

        nativeAdTypes |= AppodealAdTypeBanner;
    }

    nativeAdTypes |= AppodealAdTypeNativeAd;
    
    return nativeAdTypes;
}

int nativeShowStyleForType(int adTypes) {
    bool isInterstitial = (adTypes & INTERSTITIAL) > 0;
    bool isVideo = (adTypes & VIDEO) > 0;

    if (isInterstitial && isVideo) {
        return AppodealShowStyleVideoOrInterstitial;
    } else if (isVideo) {
        return AppodealShowStyleSkippableVideo;
    } else if (isInterstitial) {
        return AppodealShowStyleInterstitial;
    }

    if ((adTypes & BANNER_TOP) > 0) {
        return AppodealShowStyleBannerTop;
    }

    if ((adTypes & BANNER_CENTER) > 0) {
        return AppodealShowStyleBannerCenter;
    }

    if ((adTypes & BANNER_BOTTOM) > 0) {
        return AppodealShowStyleBannerBottom;
    }

    return 0;
}

@implementation AdsAppodeal

-(id) init
{
    return self;
}

-(void) destroy
{
}

-(void) setKey:(NSMutableArray*)parameters
{
    NSString* appKey = [parameters objectAtIndex:0];
    id adTypeObject = [parameters objectAtIndex:1];
    int adType = (int)[adTypeObject integerValue];

    if([parameters count] > 2) {
        id autocacheObject = [parameters objectAtIndex:2];
        bool autocache = [autocacheObject boolValue];

        if(autocache == false)
            [Appodeal setAutocache:autocache types:adType];
    }

    if([parameters count] > 3) {
        // not implemented
    }

    if([parameters count] > 4) {
        NSString* network = [parameters objectAtIndex:4];
        [Appodeal disableNetworkForAdType:AppodealAdTypeAll name:network];
    }
    
    [Appodeal disableNetworkForAdType:AppodealAdTypeAll name:kAppodealFacebookNetworkName];
    
    [Appodeal initializeWithApiKey:appKey types:nativeAdTypesForType(adType)];

    [Appodeal setBannerDelegate:(id<AppodealBannerDelegate>)self];
    [Appodeal setInterstitialDelegate:(id<AppodealInterstitialDelegate>)self];
    [Appodeal setVideoDelegate:(id<AppodealVideoDelegate>)self];
    [Appodeal setRewardedVideoDelegate:(id<AppodealRewardedVideoDelegate>)self];
}

-(void)loadAd:(NSMutableArray *)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal cacheAd:nativeAdTypesForType(adType)];
}

-(void)showAd:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal showAd:nativeShowStyleForType(adType) rootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (void) showAdWithPriceFloor:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal showAdWithPriceFloor:nativeShowStyleForType(adType) rootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

-(void)hideAd:(NSString*)type
{
    [Appodeal hideBanner];
}

- (void) disableNetworkForAdType:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal disableNetworkForAdType:nativeAdTypesForType(adType) name:[parameters objectAtIndex:1]];
}

- (void) deinitialize:(NSMutableArray*)parameters
{
    [Appodeal deinitialize];
}

/// delegates
- (void)bannerDidLoadAd
{
    NSLog(@"bannerDidLoadAd");
    [AdsClass adReceived:[self class] forType:@"banner"];
}

- (void)bannerDidFailToLoadAd
{
    NSLog(@"bannerDidFailToLoadAd");
    [AdsClass adFailed:[self class] with:@"" forType:@"banner"];
}

- (void)bannerDidClick
{
    NSLog(@"bannerDidClick");
    [AdsClass adActionEnd:[self class] forType:@"banner"];
}

- (void)bannerDidShow
{
    NSLog(@"bannerDidShow");
    [AdsClass adActionEnd:[self class] forType:@"banner"];
}

- (void)interstitialDidLoadAd
{
    NSLog(@"interstitialDidLoadAd");
    [AdsClass adReceived:[self class] forType:@"interstitial"];
}

- (void)interstitialDidFailToLoadAd
{
    NSLog(@"interstitialDidFailToLoadAd");
    [AdsClass adFailed:[self class] with:@"" forType:@"interstitial"];
}

- (void)interstitialWillPresent
{
    NSLog(@"interstitialWillPresent");
    [AdsClass adDisplayed:[self class] forType:@"interstitial"];
}

- (void)interstitialDidDismiss
{
    NSLog(@"interstitialDidDismiss");
    [AdsClass adDismissed:[self class] forType:@"interstitial"];
}

- (void)interstitialDidClick
{
    NSLog(@"interstitialDidClick");
    [AdsClass adActionEnd:[self class] forType:@"interstitial"];
}

- (void)videoDidLoadAd
{
    NSLog(@"videoDidLoadAd");
    [AdsClass adReceived:[self class] forType:@"video"];
}

- (void)videoDidFailToLoadAd
{
    NSLog(@"videoDidFailToLoadAd");
    [AdsClass adFailed:[self class] with:@"" forType:@"video"];
}

- (void)videoDidPresent
{
    NSLog(@"videoDidPresent");
    [AdsClass adDisplayed:[self class] forType:@"video"];
}

- (void)videoWillDismiss
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"video"];
}

- (void)videoDidFinish
{
    NSLog(@"videoDidFinish");
    //
    [AdsClass adDismissed:[self class] forType:@"video"];
}


// rewarded video

- (void)rewardedVideoDidLoadAd
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"rewardedvideo"];
}

- (void)rewardedVideoDidFailToLoadAd
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"rewardedvideo"];
}

- (void)rewardedVideoWillDismiss
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"rewardedvideo"];
}

- (void)rewardedVideoDidPresent
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"rewardedvideo"];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"rewardedvideo"];
}

- (void)rewardedVideoDidClick
{
    NSLog(@"videoWillDismiss");
    [AdsClass adDismissed:[self class] forType:@"rewardedvideo"];
}

- (void) disableLocationCheck
{
    [Appodeal disableLocationPermissionCheck];
}


//native callbacks
- (void)nativeAdDidClick:(AppodealNativeAd *)nativeAd
{
    NSLog(@"nativeAdDidClick");
    [AdsClass adDismissed:[self class] forType:@"native"];
}

- (void)nativeAdDidPresent:(AppodealNativeAd *)nativeAd
{
    NSLog(@"nativeAdDidPresent");
    [AdsClass adDisplayed:[self class] forType:@"native"];
}

- (void)nativeAdServiceDidFailedToLoad:(AppodealNativeAd *)nativeAd
{
    NSLog(@"nativeAdServiceDidFailedToLoad");
    [AdsClass adFailed:[self class] with:@"" forType:@"native"];
}

-(AppodealNativeAdViewAttributes *) attributes
{
    if(!_attributes)
        _attributes=[[AppodealNativeAdViewAttributes alloc] init];
    return _attributes;
}

- (NSInteger)appodealAdViewTypeConvert:(NSString*) adViewType
{
    NSInteger adtype=1;
    if([adViewType isEqualToString:@"AppodealNativeAdTypeNewsFeed"])
        adtype=AppodealNativeAdTypeNewsFeed;
    if([adViewType isEqualToString:@"AppodealNativeAdTypeContentStream"])
        adtype=AppodealNativeAdTypeContentStream;
    if([adViewType isEqualToString:@"AppodealNativeAdType320x50"])
        adtype=AppodealNativeAdType320x50;
    if([adViewType isEqualToString:@"AppodealNativeAdType728x90"])
        adtype=AppodealNativeAdType728x90;
    
    return adtype;
}

- (void) loadNativeAd:(NSMutableArray*)parameters
{
    self.adService = [[AppodealNativeAdService alloc] init];
    self.adService.delegate = self;
    [self.adService loadAd];
}

- (void)nativeAdServiceDidLoad: (AppodealNativeAd*) nativeAd{
    self.ad = nativeAd;
    //self.adView = [AppodealNativeAdView nativeAdViewWithType:self.adViewType andNativeAd:self.ad andAttributes:self.attributes rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
    //[self.adView setFrame: CGRectMake(self.x, self.y, self.attributes.width, self.attributes.heigth)];

    self.myView = [[UIView alloc] init];
    [self.myView setFrame: CGRectMake(10, 450, 200, 200)];
    [self.myView setBackgroundColor:[UIColor clearColor]];

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.ad.image.imageUrl]];
    UIImageView* blockView = [[UIImageView alloc] initWithImage:image];
    blockView.frame = CGRectMake(0 ,0, 50,50);
    [self.myView addSubview:blockView];
    
    UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.ad.icon.imageUrl]];
    UIImageView* blockView1 = [[UIImageView alloc] initWithImage:icon];
    blockView1.frame = CGRectMake(55 ,0, 50,50);
    [self.myView addSubview:blockView1];
    
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 20)];
    [yourLabel setTextColor:[UIColor blackColor]];
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
    [yourLabel setText:self.ad.title];
    [self.myView addSubview:yourLabel];
    
    UILabel *yourLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
    [yourLabel1 setTextColor:[UIColor blackColor]];
    [yourLabel1 setBackgroundColor:[UIColor clearColor]];
    [yourLabel1 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
    [yourLabel1 setText:self.ad.subtitle];
    [self.myView addSubview:yourLabel1];
    
    UILabel *yourLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
    [yourLabel2 setTextColor:[UIColor blackColor]];
    [yourLabel2 setBackgroundColor:[UIColor clearColor]];
    [yourLabel2 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
    [yourLabel2 setText:self.ad.descriptionText];
    [self.myView addSubview:yourLabel2];
    
    UILabel *yourLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
    [yourLabel4 setTextColor:[UIColor blackColor]];
    [yourLabel4 setBackgroundColor:[UIColor clearColor]];
    [yourLabel4 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
    [yourLabel4 setText:self.ad.callToActionText];
    [self.myView addSubview:yourLabel4];
    
    UILabel *yourLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
    [yourLabel5 setTextColor:[UIColor blackColor]];
    [yourLabel5 setBackgroundColor:[UIColor clearColor]];
    [yourLabel5 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
    [yourLabel5 setText:self.ad.contentRating];
    [self.myView addSubview:yourLabel5];
    [self.ad attachToView:self.myView viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
    [[[UIApplication sharedApplication] keyWindow].rootViewController.view addSubview:self.myView];
    NSLog(@"nativeAdServiceDidLoad");
    [AdsClass adReceived:[self class] forType:@"native"];
}

- (void)attachToView:(NSMutableArray*)parameters
{
    [self.ad attachToView:self.adView viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
}

- (void)detachFromView:(NSMutableArray*)parameters
{
    [self.ad detachFromView];
}

- (void)setNativeAdAttributes_width_height:(NSMutableArray*)parameters
{
    self.attributes.width=[[parameters objectAtIndex:0] floatValue];
    self.attributes.heigth=[[parameters objectAtIndex:1] floatValue];
}

- (void)setNativeAdAttributes_roundedIcon:(NSMutableArray*)parameters
{
    self.attributes.roundedIcon=[[parameters objectAtIndex:0] boolValue];
}

- (void)setNativeAdAttributes_sponsored:(NSMutableArray*)parameters
{
    self.attributes.sponsored=[[parameters objectAtIndex:0] boolValue];
}

//name, size
- (void)setNativeAdAttributes_titleFont:(NSMutableArray*)parameters
{
    self.attributes.titleFont=[UIFont fontWithName:[parameters objectAtIndex:0] size:[[parameters objectAtIndex:1] intValue]];
}

- (void)setNativeAdAttributes_descriptionFont:(NSMutableArray*)parameters
{
    self.attributes.descriptionFont=[UIFont fontWithName:[parameters objectAtIndex:0] size:[[parameters objectAtIndex:1] intValue]];
}

- (void)setNativeAdAttributes_subtitleFont:(NSMutableArray*)parameters
{
    self.attributes.subtitleFont=[UIFont fontWithName:[parameters objectAtIndex:0] size:[[parameters objectAtIndex:1] intValue]];
}

- (void)setNativeAdAttributes_buttonTitleFont:(NSMutableArray*)parameters
{
    self.attributes.buttonTitleFont=[UIFont fontWithName:[parameters objectAtIndex:0] size:[[parameters objectAtIndex:1] intValue]];
}

- (void)setNativeAdAttributes_titleFontColor:(NSMutableArray*)parameters
{
    self.attributes.titleFontColor=[UIColor colorWithRed:[[parameters objectAtIndex:0] floatValue]
                                                   green:[[parameters objectAtIndex:1] floatValue]
                                                    blue:[[parameters objectAtIndex:2] floatValue]
                                                   alpha:[[parameters objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_descriptionFontColor:(NSMutableArray*)parameters
{
    self.attributes.descriptionFontColor=[UIColor colorWithRed:[[parameters objectAtIndex:0] floatValue]
                                                         green:[[parameters objectAtIndex:1] floatValue]
                                                          blue:[[parameters objectAtIndex:2] floatValue]
                                                         alpha:[[parameters objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_subtitleColor:(NSMutableArray*)parameters
{
    self.attributes.subtitleColor=[UIColor colorWithRed:[[parameters objectAtIndex:0] floatValue]
                                                  green:[[parameters objectAtIndex:1] floatValue]
                                                   blue:[[parameters objectAtIndex:2] floatValue]
                                                  alpha:[[parameters objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_buttonColor:(NSMutableArray*)parameters
{
    self.attributes.buttonColor=[UIColor colorWithRed:[[parameters objectAtIndex:0] floatValue]
                                                green:[[parameters objectAtIndex:1] floatValue]
                                                 blue:[[parameters objectAtIndex:2] floatValue]
                                                alpha:[[parameters objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_starRatingColor:(NSMutableArray*)parameters
{
    self.attributes.starRatingColor=[UIColor colorWithRed:[[parameters objectAtIndex:0] floatValue]
                                                    green:[[parameters objectAtIndex:1] floatValue]
                                                     blue:[[parameters objectAtIndex:2] floatValue]
                                                    alpha:[[parameters objectAtIndex:3] floatValue]];
}

- (void) isInitalized:(NSMutableArray*)parameters
{
    [Appodeal isInitalized];
}

- (void) isAutocacheEnabled:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal isAutocacheEnabled:nativeAdTypesForType(adType)];
}

- (void) testingEnabled:(NSMutableArray*)parameters
{
    BOOL testingEnabled = [parameters objectAtIndex:0];
    [Appodeal setTestingEnabled:testingEnabled];
}

- (void) isReadyForShowWithStyle:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal isReadyForShowWithStyle:nativeShowStyleForType(adType)];
}

- (void) isReadyWithPriceFloorForShowWithStyle:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal isReadyWithPriceFloorForShowWithStyle:nativeShowStyleForType(adType)];
}

- (void)confirmUsage:(NSMutableArray*)parameters
{
    id adTypeObject = [parameters objectAtIndex:0];
    int adType = (int)[adTypeObject integerValue];
    [Appodeal confirmUsage:nativeAdTypesForType(adType)];
}

- (void) getVersion:(NSMutableArray*)parameters
{
    [Appodeal getVersion];
}

- (void) setUserId:(NSMutableArray*)parameters
{
    NSString* userId = [parameters objectAtIndex:0];
    [Appodeal setUserId:userId];
}

- (void) setUserVkId:(NSMutableArray*)parameters
{
    NSString* userId = [parameters objectAtIndex:0];
    [Appodeal setUserVkId:userId];
}

- (void) setUserFacebookId:(NSMutableArray*)parameters
{
    NSString* userId = [parameters objectAtIndex:0];
    [Appodeal setUserFacebookId:userId];
}

- (void) setUserEmail:(NSMutableArray*)parameters
{
    NSString* userId = [parameters objectAtIndex:0];
    [Appodeal setUserEmail:userId];
}

- (void) setUserBirthday:(NSMutableArray*)parameters
{
    //format "1996-12-19T16:39:57-08:00"
    //NSString *string = [[command arguments] objectAtIndex:0];
    //NSDate *date = [RFC3339DateFormatter dateFromString:string];
    //[Appodeal setUserBirthday:date];
}

- (void) setUserAge:(NSMutableArray*)parameters
{
    //  NSUInteger* age = [[command arguments] objectAtIndex:0];
    //  [Appodeal setUserAge:age];
}

- (void) setUserGender:(NSMutableArray*)parameters
{
    NSString* AppodealUserGender = [parameters objectAtIndex:0];
    
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderOther"])
        [Appodeal setUserGender:AppodealUserGenderOther];
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderMale"])
        [Appodeal setUserGender:AppodealUserGenderMale];
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderFemale"])
        [Appodeal setUserGender:AppodealUserGenderFemale];
}

- (void) setUserOccupation:(NSMutableArray*)parameters
{
    NSString* AppodealUserOccupation = [parameters objectAtIndex:0];
    
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationOther"])
        [Appodeal setUserOccupation:AppodealUserOccupationOther];
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationWork"])
        [Appodeal setUserOccupation:AppodealUserOccupationWork];
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationSchool"])
        [Appodeal setUserOccupation:AppodealUserOccupationSchool];
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationUniversity"])
        [Appodeal setUserOccupation:AppodealUserOccupationUniversity];
}

- (void) setUserRelationship:(NSMutableArray*)parameters
{
    NSString* AppodealUserRelationship = [parameters objectAtIndex:0];
    
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipOther"])
        [Appodeal setUserRelationship:AppodealUserRelationshipOther];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipSingle"])
        [Appodeal setUserRelationship:AppodealUserRelationshipSingle];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipDating"])
        [Appodeal setUserRelationship:AppodealUserRelationshipDating];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipEngaged"])
        [Appodeal setUserRelationship:AppodealUserRelationshipEngaged];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipMarried"])
        [Appodeal setUserRelationship:AppodealUserRelationshipMarried];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipSearching"])
        [Appodeal setUserRelationship:AppodealUserRelationshipSearching];
}

- (void) setUserSmokingAttitude:(NSMutableArray*)parameters
{
    NSString* AppodealUserSmokingAttitude = [parameters objectAtIndex:0];
    
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudeNegative"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNegative];
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudeNeutral"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNeutral];
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudePositive"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudePositive];
}

- (void) setUserAlcoholAttitude:(NSMutableArray*)parameters
{
    NSString* AppodealUserAlcoholAttitude = [parameters objectAtIndex:0];
    
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudeNegative"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNegative];
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudeNeutral"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNeutral];
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudePositive"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudePositive];
}

- (void) setUserInterests:(NSMutableArray*)parameters
{
    NSString* Interests = [parameters objectAtIndex:0];
    [Appodeal setUserInterests:Interests];
}


@end
