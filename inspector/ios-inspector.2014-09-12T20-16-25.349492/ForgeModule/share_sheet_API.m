
#import "share_sheet_API.h"
#import "TRActivity.h"

@implementation share_sheet_API

//
// Here you can implement your API methods which can be called from JavaScript
// an example method is included below to get you started.
//

// This will be callable from JavaScript as 'share_sheet.showAlert'
// it will require a parameter called text

+ (void)show:(ForgeTask*)task text:(NSString *)text url:(NSString *)url archived:(NSString *)archived publicLink:(NSString *)publicLink {
    
    UIView *mainView = [[[ForgeApp sharedApp] viewController] view];
    
    TRActivity *activity = [[TRActivity alloc] initWithText:text URL:url archived:[archived boolValue] publicURL:publicLink];
    [activity presentControllerInView:mainView];

}

@end
