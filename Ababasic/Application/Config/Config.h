//
//  Config.m


//#define SERVER_URL @"http://172.16.1.24/woof/back-end"
#define SERVER_URL @"http://52.41.100.140"
//#define SERVER_URL @"http://thetrainapp.com/admin2"

#define API_KEY @"j05wd2ae49d212578ef13cb607cef64b"

#define API_URL (SERVER_URL @"/api")
#define API_URL_USER_SIGNUP (SERVER_URL @"/api/user_signup")
#define API_URL_USER_LOGIN (SERVER_URL @"/api/v1/accounts/sign_in")
//#define API_URL_USER_RETRIEVE_PASSWORD (SERVER_URL @"/api/user_retrieve_password")
#define API_URL_USER_LOGOUT (SERVER_URL @"/api/v1/accounts/sign_out")
#define API_URL_GET_CLIENTS (SERVER_URL @"/api/v1/clients")

#define API_URL_EXPLORE_BARKS (SERVER_URL @"/api/explore_barks")
#define API_URL_LIKE_BARKS (SERVER_URL @"/api/like_barks")
#define API_URL_BARK_STAT (SERVER_URL @"/api/bark_stat")
#define API_URL_LIKE_USER (SERVER_URL @"/api/like_user")
#define API_URL_REPORT_USER (SERVER_URL @"/api/report_user")
#define API_URL_MY_BARKS (SERVER_URL @"/api/my_barks")
#define API_URL_REMOVE_LIKED_BARKS (SERVER_URL @"/api/remove_liked_barks")
#define API_URL_FAVORITE_BARKS (SERVER_URL @"/api/favorite_barks")
#define API_URL_PROFILE_UPDATE (SERVER_URL @"/api/profile_update")
#define API_URL_DISCOVERY_SETTINGS (SERVER_URL @"/api/discovery_settings")
#define API_URL_LOCATION_SETTINGS (SERVER_URL @"/api/location_settings")
#define API_URL_USER_SETTINGS_LOCATION_ID (SERVER_URL @"/api/user_settings_location_id")

// MEDIA CONFIG
#define MEDIA_INTRO_URL (SERVER_URL @"/assets/intro/")
#define MEDIA_INTRO_URL_GET_STARTED @"#getStarted"

#define MEDIA_USER_SELF_DOMAIN_PREFIX @"wf_media_user_"
#define MEDIA_AVATAR_SELF_DOMAIN_PREFIX @"wf_avatar_"
#define MEDIA_BARK_PHOTO_SELF_DOMAIN_PREFIX @"wf_media_bark_photo_"
#define MEDIA_BARK_VIDEO_SELF_DOMAIN_PREFIX @"wf_media_bark_video_"
#define MEDIA_BARK_VIDEO_THUMB_SELF_DOMAIN_PREFIX @"wf_media_bark_video_thumb_"

#define MEDIA_URL (SERVER_URL @"/assets/media/")
#define MEDIA_URL_USERS (SERVER_URL @"/assets/media/users/")
#define MEDIA_URL_BARK_PHOTOS (SERVER_URL @"/assets/media/bark_photos/")
#define MEDIA_URL_BARK_VIDEOS (SERVER_URL @"/assets/media/bark_videos/")
#define MEDIA_URL_BARK_VIDEO_THUMBS (SERVER_URL @"/assets/media/bark_video_thumbs/")

// Settings Config
#define USER_AGE_MIN 18
#define USER_AGE_MAX 80

// Explore Barks Default Config
#define EXPLORE_BARKS_COUNT_DEFAULT @"100"

// Aviary Config
//#define kAviaryKey @"j8q6p8efaolydstk"
//#define kAviarySecret @"kk4fd7pglcnrgbpd"
#define ADOBE_CLIENT_ID @"05cce7d40c12458bb4f13db89903044c"
#define ADOBE_CLIENT_SECRET @"28e16f52-6acd-4e7a-bdbd-86b0f670d8a4"


// Map View Default Config
#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360


// Utility Values
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]
#define M_PI        3.14159265358979323846264338327950288

#define FONT_GOTHAM_NORMAL(s) [UIFont fontWithName:@"GothamRounded-Book" size:s]
#define FONT_GOTHAM_BOLD(s) [UIFont fontWithName:@"GothamRounded-Bold" size:s]


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_6_OR_ABOVE (IS_IPHONE && SCREEN_MAX_LENGTH >= 667.0)
