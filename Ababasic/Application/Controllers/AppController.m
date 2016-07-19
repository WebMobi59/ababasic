//
//  AppController.m


#import "AppController.h"

static AppController *_appController;

@implementation AppController

+ (AppController *)sharedInstance {
    static dispatch_once_t predicate;
    if (_appController == nil) {
        dispatch_once(&predicate, ^{
            _appController = [[AppController alloc] init];
        });
    }
    return _appController;
}

- (id)init {
    self = [super init];
    if (self) {
        
        // Utility Data
        _appMainColor = RGBA(254, 242, 91, 1.0f);
        _appTextColor = RGBA(41, 43, 48, 1.0f);
        _appThirdColor = RGBA(61, 155, 196, 1.0f);
        
        _vAlert = [[DoAlertView alloc] init];
        _vAlert.nAnimationType = 2;  // there are 5 type of animation
        _vAlert.dRound = 7.0;
        _vAlert.bDestructive = NO;  // for destructive mode
        //        _vAlert.iImage = [UIImage imageNamed:@"logo_top"];
        //        _vAlert.nContentMode = DoContentImage;
        
        
        
        // Intro Images
        _introSliderImages = (NSMutableArray *) @[
                                                  @"intro1",
                                                  @"intro2",
                                                  @"intro3"
                                                  ];
        
        // Side Menu Bar Pages
        _menuPages = [[NSMutableArray alloc] init];
        _menuPages = [@[
                        [@{@"tag" : @"1", @"title" : @"Explore Barks", @"icon" : @"menu_explorebarks"} mutableCopy],
                        [@{@"tag" : @"2", @"title" : @"My Barks", @"icon" : @"menu_mybarks"} mutableCopy],
                        [@{@"tag" : @"3", @"title" : @"Liked Barks", @"icon" : @"menu_likedbarks"} mutableCopy],
                        [@{@"tag" : @"4", @"title" : @"Favorite Barkers", @"icon" : @"menu_favoritebarkers"} mutableCopy],
                        [@{@"tag" : @"5", @"title" : @"Settings", @"icon" : @"menu_settings"} mutableCopy],
                        [@{@"tag" : @"6", @"title" : @"Share Woof", @"icon" : @"menu_sharewoof"} mutableCopy]
                        ] mutableCopy];
        
        _avatars = [[NSMutableArray alloc] init];
        _avatars = [@[
                        [@{@"tag" : @"01", @"color" : RGBA(255, 114, 113, 1.0f)} mutableCopy],
                        [@{@"tag" : @"02", @"color" : RGBA(255, 191, 55, 1.0f)} mutableCopy],
                        [@{@"tag" : @"03", @"color" : RGBA(253, 242, 92, 1.0f)} mutableCopy],
                        [@{@"tag" : @"04", @"color" : RGBA(186, 248, 53, 1.0f)} mutableCopy],
                        [@{@"tag" : @"05", @"color" : RGBA(72, 222, 89, 1.0f)} mutableCopy],
                        [@{@"tag" : @"06", @"color" : RGBA(5, 230, 174, 1.0f)} mutableCopy],
                        [@{@"tag" : @"07", @"color" : RGBA(50, 252, 238, 1.0f)} mutableCopy],
                        [@{@"tag" : @"08", @"color" : RGBA(162, 222, 255, 1.0f)} mutableCopy],
                        [@{@"tag" : @"09", @"color" : RGBA(98, 190, 255, 1.0f)} mutableCopy],
                        [@{@"tag" : @"10", @"color" : RGBA(190, 184, 255, 1.0f)} mutableCopy],
                        [@{@"tag" : @"11", @"color" : RGBA(255, 150, 198, 1.0f)} mutableCopy],
                        [@{@"tag" : @"12", @"color" : RGBA(198, 213, 220, 1.0f)} mutableCopy]
                        ] mutableCopy];
        
        _statsPeriods = [[NSMutableArray alloc] init];
        _statsPeriods = [@[
                           [@{@"tag" : @"1", @"text" : @"1D", @"days" : @"1"} mutableCopy],
                           [@{@"tag" : @"2", @"text" : @"1W", @"days" : @"7"} mutableCopy],
                           [@{@"tag" : @"3", @"text" : @"1M", @"days" : @"30"} mutableCopy],
                           [@{@"tag" : @"4", @"text" : @"3M", @"days" : @"90"} mutableCopy],
                           [@{@"tag" : @"5", @"text" : @"6M", @"days" : @"180"} mutableCopy],
                           [@{@"tag" : @"6", @"text" : @"1Y", @"days" : @"365"} mutableCopy],
                           [@{@"tag" : @"7", @"text" : @"2Y", @"days" : @"730"} mutableCopy]
                           ] mutableCopy];
        
        // Nav Temporary Data
        _currentNavBark = [[NSMutableDictionary alloc] init];
        _currentNavBarkStat = [[NSMutableDictionary alloc] init];
        _postBarkImage = nil;
        _editProfileImage = nil;
        _currentMenuTag = @"1";
        _avatarUrlTemp = @"";
        _facebookPhotoUrlTemp = @"";
        _statsVelocityHistoryPeriod = @"30";
        
        _isFromSignUpSecondPage = NO;
        _isNewBarkUploaded = NO;
        _isMyProfileChanged = NO;
        
        // Data
        _currentUser = [[NSMutableDictionary alloc] init];
        
        _barks = [[NSMutableArray alloc] init];
//        _barks = [@[
//                     [@{
//                        @"bark_id" : @"1",
//                        @"bark_user_id" : @"1",
//                        @"bark_user_name" : @"michaelben",
//                        @"bark_user_photo_url" : @"wf_media_user_p1_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e3_01.png",
//                        @"bark_distance" : @"87"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"2",
//                        @"bark_user_id" : @"2",
//                        @"bark_user_name" : @"puppylover02",
//                        @"bark_user_photo_url" : @"wf_media_user_p2_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e7.png",
//                        @"bark_distance" : @"30"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"3",
//                        @"bark_user_id" : @"1",
//                        @"bark_user_name" : @"michaelben",
//                        @"bark_user_photo_url" : @"wf_media_user_p1_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e5_01.png",
//                        @"bark_distance" : @"52"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"4",
//                        @"bark_user_id" : @"4",
//                        @"bark_user_name" : @"larakristina0116",
//                        @"bark_user_photo_url" : @"wf_media_user_p5_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e10.png",
//                        @"bark_distance" : @"79"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"5",
//                        @"bark_user_id" : @"2",
//                        @"bark_user_name" : @"puppylover02",
//                        @"bark_user_photo_url" : @"wf_media_user_p2_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e9.png",
//                        @"bark_distance" : @"32"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"6",
//                        @"bark_user_id" : @"1",
//                        @"bark_user_name" : @"michaelben",
//                        @"bark_user_photo_url" : @"wf_media_user_p1_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e6.png",
//                        @"bark_distance" : @"12"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"7",
//                        @"bark_user_id" : @"4",
//                        @"bark_user_name" : @"larakristina0116",
//                        @"bark_user_photo_url" : @"wf_media_user_p5_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e8.png",
//                        @"bark_distance" : @"40"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"8",
//                        @"bark_user_id" : @"2",
//                        @"bark_user_name" : @"puppylover02",
//                        @"bark_user_photo_url" : @"wf_media_user_p2_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e1.png",
//                        @"bark_distance" : @"22"
//                        } mutableCopy],
//                     [@{
//                        @"bark_id" : @"9",
//                        @"bark_user_id" : @"4",
//                        @"bark_user_name" : @"larakristina0116",
//                        @"bark_user_photo_url" : @"wf_media_user_p5_01.png",
//                        @"bark_type" : @"1",
//                        @"bark_url" : @"wf_media_bark_e2.png",
//                        @"bark_distance" : @"24"
//                        } mutableCopy]
//                ] mutableCopy];

        
        _myBarks = [[NSMutableArray alloc] init];
//        _myBarks = [@[
//                      [@{
//                         @"bark_id" : @"6",
//                         @"bark_user_id" : @"3",
//                         @"bark_user_name" : @"jennyboot",
//                         @"bark_user_photo_url" : @"http://i609.photobucket.com/albums/tt175/kayzasoze/Models/beautiful_european_girls_73.jpg",
//                         @"bark_type" : @"1",
//                         @"bark_url" : @"wf_media_bark_e2.png",
//                         @"bc_locations" : @"40.741133:-73.692507;1,40.742745:-73.693697;1,40.741702:-73.695585;1,40.742847:-73.697991;0,40.737941:-73.690334;1",
//                         @"bark_location_address" : @"",
//                         @"bark_location_latitude" : @"40.741133",
//                         @"bark_location_longitude" : @"-73.692507"
//                         } mutableCopy],
//                      [@{
//                         @"bark_id" : @"7",
//                         @"bark_user_id" : @"3",
//                         @"bark_user_name" : @"jennyboot",
//                         @"bark_user_photo_url" : @"http://i609.photobucket.com/albums/tt175/kayzasoze/Models/beautiful_european_girls_73.jpg",
//                         @"bark_type" : @"1",
//                         @"bark_url" : @"wf_media_bark_e3_01.png",
//                         @"bc_locations" : @"40.741133:-73.692507;1,40.742745:-73.673697;1,40.741702:-73.685585;1,40.742847:-73.693991;0,40.737941:-73.690334;1",
//                         @"bark_location_address" : @"",
//                         @"bark_location_latitude" : @"40.741133",
//                         @"bark_location_longitude" : @"-73.692507"
//                         } mutableCopy],
//                      [@{
//                         @"bark_id" : @"8",
//                         @"bark_user_id" : @"3",
//                         @"bark_user_name" : @"jennyboot",
//                         @"bark_user_photo_url" : @"http://i609.photobucket.com/albums/tt175/kayzasoze/Models/beautiful_european_girls_73.jpg",
//                         @"bark_type" : @"1",
//                         @"bark_url" : @"wf_media_bark_e5.png",
//                         @"bc_locations" : @"40.760041:-73.665625;1,40.768435:-73.677352;1,40.754466:-73.672256;1,40.751731:-73.674108;0",
//                         @"bark_location_address" : @"",
//                         @"bark_location_latitude" : @"40.760041",
//                         @"bark_location_longitude" : @"-73.665625"
//                         } mutableCopy]
//                    ] mutableCopy];
        
        _likedBarks = [[NSMutableArray alloc] init];
//        _likedBarks = [@[
//                      [@{
//                         @"bark_id" : @"9",
//                         @"bark_user_id" : @"2",
//                         @"bark_user_name" : @"puppylover02",
//                         @"bark_user_photo_url" : @"wf_media_user_p2_01.png",
//                         @"bark_type" : @"1",
//                         @"bark_url" : @"wf_media_bark_e6.png",
//                         @"bc_locations" : @"40.741133:-73.692507;1,40.742745:-73.693697;1,40.741702:-73.695585;1,40.742847:-73.697991;0,40.737941:-73.690334;1",
//                         @"bark_location_address" : @"",
//                         @"bark_location_latitude" : @"40.741133",
//                         @"bark_location_longitude" : @"-73.692507",
//                         @"is_favorite" : @"1",
//                         @"order_id" : @"0",
//                         @"bark_distance" : @"48"
//                         } mutableCopy],
//                      [@{
//                         @"bark_id" : @"10",
//                         @"bark_user_id" : @"1",
//                         @"bark_user_name" : @"michaelben",
//                         @"bark_user_photo_url" : @"wf_media_user_p1_01.png",
//                         @"bark_type" : @"1",
//                         @"bark_url" : @"wf_media_bark_e4.png",
//                         @"bc_locations" : @"40.760041:-73.665625;1,40.768435:-73.677352;1,40.754466:-73.672256;1,40.751731:-73.674108;0",
//                         @"bark_location_address" : @"",
//                         @"bark_location_latitude" : @"40.760041",
//                         @"bark_location_longitude" : @"-73.665625",
//                         @"is_favorite" : @"0",
//                         @"order_id" : @"1",
//                         @"bark_distance" : @"6"
//                         } mutableCopy]
//                      ] mutableCopy];
        
        _favoriteUsers = [[NSMutableArray alloc] init];
    }
    return self;
}


+ (NSDictionary*) requestApi:(NSMutableDictionary *)params withFormat:(NSString *)url {
    return [AppController jsonHttpRequest:url jsonParam:params];
}

+ (id) jsonHttpRequest:(NSString*) urlStr jsonParam:(NSMutableDictionary *)params {
    NSString *paramStr = [commonUtils getParamStr:params];
    //NSLog(@"\n\nparameter string : \n\n%@", paramStr);
    NSData *requestData = [paramStr dataUsingEncoding:NSUTF8StringEncoding];

    NSData *data = nil;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSHTTPURLResponse *response = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody: requestData];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
//    NSLog(@"\n\nresponse string : \n\n%@", responseString);
    return [[SBJsonParser new] objectWithString:responseString];
}

@end
