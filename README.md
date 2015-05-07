### CFEED (a la CSPAN)

### See what members of Congress and federally elected officials are Tweeting

#### iPhone (iOS 8+) App written in Swift.
The purpose of this CFEED is to get a feel for these Swift frameworks using something reasonably "real".
After using _AFNetworking_ and _Mantle_ in previous Obj-C projects, I wanted to see how _Alamofire_ and _ObjectMapper_ stacked up.
Also discovered that _Dollar_ does a great job of adding some FP-like tools to the Swift environment.

Initially CFEED will display (readonly) Twitter timelines for a user selected member of Congress.

#### Tests use of the following:
*   Public Webservices:
     *   [Govtrack.us public API](https://www.govtrack.us/developers/api)
     *   [Twitter API](https://dev.twitter.com/rest/public)
*   3rd Party Frameworks:
     *   [Alamofire](https://github.com/Alamofire/Alamofire) (networking)
     *   [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) (JSON serialization)
     *   [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
     *   [MBProgressHUD](https://github.com/jdg/MBProgressHUD) (Simple HUD; Obj-C)
     *   [Dollar](https://github.com/ankurp/Dollar.swift)
*   [Cocoapods](https://cocoapods.org/) (v 0.36.4 for swift projects)

#### TODOs
*   Complete Twitter Timeline Queries
*   Save settings for NSUserDefaults
*   Implement Favorite List
*   [Youtube Feeds](https://developers.google.com/youtube/v3/getting-started)

#### Possibly Doing
*   Obtain Financing data from [OpenSecrets.org](http://www.opensecrets.org/resources/create/apis.php)

#### Not Doing
*   Swift Testing (Looking at [Quick/Nimble](https://github.com/Quick/Quick) (rspec-ish) for future projects)
