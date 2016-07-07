#ifndef ADS_H
#define ADS_H

#include <gglobal.h>
#include <gevent.h>

enum
{
	GADS_AD_RECEIVED_EVENT,
	GADS_AD_FAILED_EVENT,
	GADS_AD_ACTION_BEGIN_EVENT,
	GADS_AD_ACTION_END_EVENT,
	GADS_AD_DISMISSED_EVENT,
    GADS_AD_DISPLAYED_EVENT,
	GADS_AD_ERROR_EVENT,
};

typedef struct gads_AdErrorEvent
{
	const char *ad;
	const char *error;
} gads_AdErrorEvent;

typedef struct gads_AdFailedEvent
{
	const char *ad;
    const char *type;
	const char *error;
} gads_AdFailedEvent;

typedef struct gads_SimpleEvent
{
	const char *ad;
    const char *type;
} gads_SimpleEvent;

typedef struct gads_Parameter
{
    const char *value;
} gads_Parameter;

#ifdef __cplusplus
extern "C" {
#endif

G_API int gads_isAvailable();

G_API void gads_init();
G_API void gads_cleanup();

G_API void gads_initialize(const char *ad);
G_API void gads_destroy(const char *ad);
G_API void gads_setKey(const char *ad, gads_Parameter *params);

G_API void gads_loadAd(const char *ad, gads_Parameter *params);
G_API void gads_showAd(const char *ad, gads_Parameter *params);
G_API void gads_hideAd(const char *ad, const char *type);
G_API void gads_enableTesting(const char *ad);
G_API void gads_setAlignment(const char *ad, const char *hor, const char *ver);

G_API void gads_disableNetworkForAdType(const char *ad, gads_Parameter *params);
G_API void gads_showAdWithPriceFloor(const char *ad, gads_Parameter *params);
G_API void gads_deinitialize(const char *ad);
G_API void gads_disableLocationCheck(const char *ad);
G_API void gads_loadNativeAd(const char *ad, gads_Parameter *params);
G_API void gads_attachToView(const char *ad, gads_Parameter *params);
G_API void gads_detachFromView(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_width_height(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_roundedIcon(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_sponsored(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_titleFont(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_descriptionFont(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_subtitleFont(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_buttonTitleFont(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_titleFontColor(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_descriptionFontColor(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_subtitleColor(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_buttonColor(const char *ad, gads_Parameter *params);
G_API void gads_setNativeAdAttributes_starRatingColor(const char *ad, gads_Parameter *params);
G_API void gads_isInitalized(const char *ad, gads_Parameter *params);
G_API void gads_isAutocacheEnabled(const char *ad, gads_Parameter *params);
G_API void gads_testingEnabled(const char *ad, gads_Parameter *params);
G_API void gads_isReadyForShowWithStyle(const char *ad, gads_Parameter *params);
G_API void gads_isReadyWithPriceFloorForShowWithStyle(const char *ad, gads_Parameter *params);
G_API void gads_confirmUsage(const char *ad, gads_Parameter *params);
G_API void gads_getVersion(const char *ad, gads_Parameter *params);
G_API void gads_setUserId(const char *ad, gads_Parameter *params);
G_API void gads_setUserVkId(const char *ad, gads_Parameter *params);
G_API void gads_setUserFacebookId(const char *ad, gads_Parameter *params);
G_API void gads_setUserEmail(const char *ad, gads_Parameter *params);
G_API void gads_setUserBirthday(const char *ad, gads_Parameter *params);
G_API void gads_setUserAge(const char *ad, gads_Parameter *params);
G_API void gads_setUserGender(const char *ad, gads_Parameter *params);
G_API void gads_setUserOccupation(const char *ad, gads_Parameter *params);
G_API void gads_setUserRelationship(const char *ad, gads_Parameter *params);
G_API void gads_setUserSmokingAttitude(const char *ad, gads_Parameter *params);
G_API void gads_setUserAlcoholAttitude(const char *ad, gads_Parameter *params);
G_API void gads_setUserInterests(const char *ad, gads_Parameter *params);

G_API void gads_setX(const char *ad, int x);
G_API void gads_setY(const char *ad, int y);
G_API int gads_getX(const char *ad);
G_API int gads_getY(const char *ad);
G_API int gads_getWidth(const char *ad);
G_API int gads_getHeight(const char *ad);

G_API g_id gads_addCallback(gevent_Callback callback, void *udata);
G_API void gads_removeCallback(gevent_Callback callback, void *udata);
G_API void gads_removeCallbackWithGid(g_id gid);
    
G_API void gads_adReceived(const char *ad, const char *type);
G_API void gads_adFailed(const char *ad, const char *error, const char *type);
G_API void gads_adActionBegin(const char *ad, const char *type);
G_API void gads_adActionEnd(const char *ad, const char *type);
G_API void gads_adDismissed(const char *ad, const char *type);
G_API void gads_adDisplayed(const char *ad, const char *type);
G_API void gads_adError(const char *ad, const char *error);

#ifdef __cplusplus
}
#endif

#endif