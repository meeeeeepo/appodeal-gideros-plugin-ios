//
//  AdsClass.h
//  Ads
//
//  Created by Arturs Sosins on 6/25/13.
//  Copyright (c) 2013 Gideros Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ads.h"

@interface AdsClass : NSObject

+(void)init;
+(void)cleanup;

+(UIViewController*)getRootViewController;

+(void)initialize:(NSString*)adprovider;
+(void)destroy:(NSString*)adprovider;
+(void)setKey:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)loadAd:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)showAd:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)hideAd:(NSString*)adprovider with:(NSString*)type;
+(void)enableTesting:(NSString*)adprovider;

+(void)disableNetworkForAdType:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)showAdWithPriceFloor:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)deinitialize:(NSString*)adprovider;
+(void)disableLocationCheck:(NSString*)adprovider;
+(void)loadNativeAd:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)attachToView:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)detachFromView:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_width_height:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_roundedIcon:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_sponsored:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_titleFont:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_descriptionFont:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_subtitleFont:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_buttonTitleFont:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_titleFontColor:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_descriptionFontColor:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_subtitleColor:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_buttonColor:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setNativeAdAttributes_starRatingColor:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)isInitalized:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)isAutocacheEnabled:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)testingEnabled:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)isReadyForShowWithStyle:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)isReadyWithPriceFloorForShowWithStyle:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)confirmUsage:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)getVersion:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserId:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserVkId:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserFacebookId:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserEmail:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserBirthday:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserAge:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserGender:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserOccupation:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserRelationship:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserSmokingAttitude:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserAlcoholAttitude:(NSString*)adprovider with:(NSMutableArray*)parameters;
+(void)setUserInterests:(NSString*)adprovider with:(NSMutableArray*)parameters;

+(void)setAlignment:(NSString*)adprovider with:(NSString*)hor andWith:(NSString*)ver;
+(void)setX:(NSString*)adprovider with:(int)x;
+(void)setY:(NSString*)adprovider with:(int)y;
+(int)getX:(NSString*)adprovider;
+(int)getY:(NSString*)adprovider;
+(int)getWidth:(NSString*)adprovider;
+(int)getHeight:(NSString*)adprovider;
+(BOOL)hasConnection;
+(BOOL)isPortrait;
+(void)adReceived:(Class)adprovider forType:(NSString*)type;
+(void)adFailed:(Class)adprovider with:(NSString*)error forType:(NSString*)type;
+(void)adActionBegin:(Class)adprovider forType:(NSString*)type;
+(void)adActionEnd:(Class)adprovider forType:(NSString*)type;
+(void)adDismissed:(Class)adprovider forType:(NSString*)type;
+(void)adDisplayed:(Class)adprovider forType:(NSString*)type;
+(void)adError:(Class)adprovider with:(NSString*)error;
@end
