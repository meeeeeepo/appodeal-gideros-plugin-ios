//
//  AdsClass.m
//  Ads
//
//  Created by Arturs Sosins on 6/25/13.
//  Copyright (c) 2013 Gideros Mobile. All rights reserved.
//
#include "gideros.h"
#import "AdsClass.h"
#import "AdsProtocol.h"
#import "Reachability.h"

@implementation AdsClass

static NSMutableDictionary *ads = [NSMutableDictionary dictionary];

+(void)init{
}

+(void)cleanup{
	for(NSString *key in ads){
        id ad = [ads objectForKey:key];
        [ad destroy];
        [ad release];
        ad = nil;
    }
    [ads removeAllObjects];
}

+(void)initialize:(NSString*)adprovider{
	if(![ads objectForKey:[adprovider lowercaseString]])
	{
		NSString *ProviderClass = @"Ads";
		ProviderClass = [ProviderClass stringByAppendingString:[adprovider capitalizedString]];
		id ad = [[NSClassFromString(ProviderClass) alloc] init];
		[ads setObject:ad forKey:[adprovider lowercaseString]];
	}
}

+(void)destroy:(NSString*)adprovider{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
	if(ad)
	{
        [ad destroy];
        [ad release];
        ad = nil;
		[ads removeObjectForKey:[adprovider lowercaseString]];
    }
}

+(UIViewController*)getRootViewController{
    return g_getRootViewController();;
}

+(void)setKey:(NSString*)adprovider with:(NSMutableArray*)parameters{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setKey:parameters];
    }
}

+(void)loadAd:(NSString*)adprovider with:(NSMutableArray*)parameters{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        if(![AdsClass hasConnection])
        {
            NSString *type = [parameters objectAtIndex:0];
            [AdsClass adFailed:adprovider withError:@"No Internet Connection" forType:type];
            return;
        }
        [ad loadAd:parameters];
    }
}

+(void)showAd:(NSString*)adprovider with:(NSMutableArray*)parameters{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        if(![AdsClass hasConnection])
        {
            NSString *type = [parameters objectAtIndex:0];
            [AdsClass adFailed:adprovider withError:@"No Internet Connection" forType:type];
            return;
        }
        [ad showAd:parameters];
    }
}

+(void)hideAd:(NSString*)adprovider with:(NSString*)type{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad hideAd:type];
    }
}

+(void)enableTesting:(NSString *)adprovider{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad enableTesting];
    }
}

+(void)disableNetworkForAdType:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad disableNetworkForAdType:parameters];
    }
}

+(void)showAdWithPriceFloor:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad showAdWithPriceFloor:parameters];
    }
}

+(void)deinitialize:(NSString*)adprovider{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad deinitialize];
    }
}

+(void)disableLocationCheck:(NSString*)adprovider{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad disableLocationCheck];
    }
}

+(void)loadNativeAd:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad loadNativeAd:parameters];
    }
}

+(void)attachToView:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad attachToView:parameters];
    }
}

+(void)detachFromView:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad detachFromView:parameters];
    }
}

+(void)setNativeAdAttributes_width_height:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_width_height:parameters];
    }
}

+(void)setNativeAdAttributes_roundedIcon:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_roundedIcon:parameters];
    }
}

+(void)setNativeAdAttributes_sponsored:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_sponsored:parameters];
    }
}

+(void)setNativeAdAttributes_titleFont:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_titleFont:parameters];
    }
}

+(void)setNativeAdAttributes_descriptionFont:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_descriptionFont:parameters];
    }
}

+(void)setNativeAdAttributes_subtitleFont:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_subtitleFont:parameters];
    }
}

+(void)setNativeAdAttributes_buttonTitleFont:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_buttonTitleFont:parameters];
    }
}

+(void)setNativeAdAttributes_titleFontColor:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_titleFontColor:parameters];
    }
}

+(void)setNativeAdAttributes_descriptionFontColor:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_descriptionFontColor:parameters];
    }
}

+(void)setNativeAdAttributes_subtitleColor:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_subtitleColor:parameters];
    }
}

+(void)setNativeAdAttributes_buttonColor:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_buttonColor:parameters];
    }
}

+(void)setNativeAdAttributes_starRatingColor:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setNativeAdAttributes_starRatingColor:parameters];
    }
}

+(void)isInitalized:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad isInitalized:parameters];
    }
}

+(void)isAutocacheEnabled:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad isAutocacheEnabled:parameters];
    }
}

+(void)testingEnabled:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad testingEnabled:parameters];
    }
}

+(void)isReadyForShowWithStyle:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad isReadyForShowWithStyle:parameters];
    }
}

+(void)isReadyWithPriceFloorForShowWithStyle:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad isReadyWithPriceFloorForShowWithStyle:parameters];
    }
}

+(void)confirmUsage:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad confirmUsage:parameters];
    }
}

+(void)getVersion:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad getVersion:parameters];
    }
}

+(void)setUserId:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserId:parameters];
    }
}

+(void)setUserVkId:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserVkId:parameters];
    }
}

+(void)setUserFacebookId:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserFacebookId:parameters];
    }
}

+(void)setUserEmail:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserEmail:parameters];
    }
}

+(void)setUserBirthday:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserBirthday:parameters];
    }
}

+(void)setUserAge:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserAge:parameters];
    }
}

+(void)setUserGender:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserGender:parameters];
    }
}

+(void)setUserOccupation:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserOccupation:parameters];
    }
}

+(void)setUserRelationship:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserRelationship:parameters];
    }
}

+(void)setUserSmokingAttitude:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserSmokingAttitude:parameters];
    }
}

+(void)setUserAlcoholAttitude:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserAlcoholAttitude:parameters];
    }
}

+(void)setUserInterests:(NSString*)adprovider with:(NSMutableArray*)parameters{
    id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
        [ad setUserInterests:parameters];
    }
}



+(void)setAlignment:(NSString*)adprovider with:(NSString*)hor andWith:(NSString*)ver{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
			float x = 0;
			float y = 0;
			float screenWidth = 0;
			float screenHeight = 0;
			CGRect screenRect = [[UIScreen mainScreen] bounds];
			if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
			{
				screenWidth = screenRect.size.width;
				screenHeight = screenRect.size.height;
			}
			else
			{
				screenWidth = screenRect.size.height;
				screenHeight = screenRect.size.width;
			}
			if([hor isEqualToString:@"right"]){
				x = screenWidth - view_.frame.size.width;
			}
			else if([hor isEqualToString:@"center"]){
				x = (screenWidth - view_.frame.size.width)/2;
			}
		
			if([ver isEqualToString:@"bottom"]){
				y = screenHeight - view_.frame.size.height;
			}
			else if([ver isEqualToString:@"center"]){
				y = (screenHeight - view_.frame.size.height)/2;
			}
			[view_ setFrame:CGRectMake(x, y, view_.frame.size.width, view_.frame.size.height)];
		}
    }
}

+(void)setX:(NSString*)adprovider with:(int)x{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
            [view_ setFrame:CGRectMake(x, view_.frame.origin.y, view_.frame.size.width, view_.frame.size.height)];
        }
    }
}

+(void)setY:(NSString*)adprovider with:(int)y{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
            [view_ setFrame:CGRectMake(view_.frame.origin.x, y, view_.frame.size.width, view_.frame.size.height)];
        }
    }
}

+(int)getX:(NSString*)adprovider{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
            return view_.frame.origin.x;
        }
    }
    return 0;
}

+(int)getY:(NSString*)adprovider{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
            return view_.frame.origin.y;
        }
    }
    return 0;
}

+(int)getWidth:(NSString*)adprovider{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
            return view_.frame.size.width;
        }
    }
    return 0;
}

+(int)getHeight:(NSString*)adprovider{
	id ad = [ads objectForKey:[adprovider lowercaseString]];
    if (ad) {
		UIView *view_ = [ad getView];
		if(view_ != nil)
		{
            return view_.frame.size.height;
        }
    }
    return 0;
}

+(BOOL)hasConnection{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

+(BOOL)isPortrait{
    return ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

+(void)adReceived:(Class)adprovider forType:(NSString*)type{
    gads_adReceived([[AdsClass modifyName:adprovider] UTF8String], [type UTF8String]);
}

+(void)adFailed:(Class)adprovider with:(NSString*)error forType:(NSString*)type{
    gads_adFailed([[AdsClass modifyName:adprovider] UTF8String], [error UTF8String], [type UTF8String]);
}

+(void)adFailed:(NSString*)adprovider withError:(NSString*)error forType:(NSString*)type{
    gads_adFailed([adprovider UTF8String], [error UTF8String], [type UTF8String]);
}

+(void)adActionBegin:(Class)adprovider forType:(NSString*)type{
    gads_adActionBegin([[AdsClass modifyName:adprovider] UTF8String], [type UTF8String]);
}

+(void)adActionEnd:(Class)adprovider forType:(NSString*)type{
    gads_adActionEnd([[AdsClass modifyName:adprovider] UTF8String], [type UTF8String]);
}

+(void)adDisplayed:(Class)adprovider forType:(NSString*)type{
    gads_adDisplayed([[AdsClass modifyName:adprovider] UTF8String], [type UTF8String]);
}

+(void)adDismissed:(Class)adprovider forType:(NSString*)type{
    gads_adDismissed([[AdsClass modifyName:adprovider] UTF8String], [type UTF8String]);
}

+(void)adError:(Class)adprovider with:(NSString*)error{
    gads_adError([[AdsClass modifyName:adprovider] UTF8String],[error UTF8String]);
}

+(NSString*)modifyName:(Class)name{
    NSString *cname = NSStringFromClass(name);
    cname = [cname stringByReplacingOccurrencesOfString:@"Ads" withString:@""];
    return [cname lowercaseString];
}

@end
