//
//  AdsProtocol.h
//  Ads
//
//  Created by Arturs Sosins on 6/25/13.
//  Copyright (c) 2013 Gideros Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdsProtocol <NSObject>

-(id)init;
-(void)destroy;
-(void)setKey:(NSMutableArray*)parameters;
-(void)loadAd:(NSMutableArray*)parameters;
-(void)showAd:(NSMutableArray*)parameters;
-(void)hideAd:(NSString*)type;
-(void)showAdWithPriceFloor:(NSMutableArray*)parameters;
-(void)deinitialize:(NSMutableArray*)parameters;
-(void)disableLocationCheck;
-(void)disableNetworkForAdType:(NSMutableArray*)parameters;
-(void)loadNativeAd:(NSMutableArray*)parameters;
-(void)attachToView:(NSMutableArray*)parameters;
-(void)detachFromView:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_width_height:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_roundedIcon:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_sponsored:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_titleFont:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_descriptionFont:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_subtitleFont:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_buttonTitleFont:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_titleFontColor:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_descriptionFontColor:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_subtitleColor:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_buttonColor:(NSMutableArray*)parameters;
-(void)setNativeAdAttributes_starRatingColor:(NSMutableArray*)parameters;
-(void)isInitalized:(NSMutableArray*)parameters;
-(void)isAutocacheEnabled:(NSMutableArray*)parameters;
-(void)testingEnabled:(NSMutableArray*)parameters;
-(void)isReadyForShowWithStyle:(NSMutableArray*)parameters;
-(void)isReadyWithPriceFloorForShowWithStyle:(NSMutableArray*)parameters;
-(void)confirmUsage:(NSMutableArray*)parameters;
-(void)getVersion:(NSMutableArray*)parameters;
-(void)setUserId:(NSMutableArray*)parameters;
-(void)setUserVkId:(NSMutableArray*)parameters;
-(void)setUserFacebookId:(NSMutableArray*)parameters;
-(void)setUserEmail:(NSMutableArray*)parameters;
-(void)setUserBirthday:(NSMutableArray*)parameters;
-(void)setUserAge:(NSMutableArray*)parameters;
-(void)setUserGender:(NSMutableArray*)parameters;
-(void)setUserOccupation:(NSMutableArray*)parameters;
-(void)setUserRelationship:(NSMutableArray*)parameters;
-(void)setUserSmokingAttitude:(NSMutableArray*)parameters;
-(void)setUserAlcoholAttitude:(NSMutableArray*)parameters;
-(void)setUserInterests:(NSMutableArray*)parameters;
-(UIView*)getView;

@end
