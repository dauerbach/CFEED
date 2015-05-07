//
//  AppDelegate.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/2/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   static let twitter_consumer_key = "mJxbqoFKfcrMpEwznloWRxwbE"
   static let twitter_consumer_secret = "r0MQo0CEI7jRRn08RC9CgnjnyMrywGCAG0Ab3Dcny1RbUGXIqj"

   static let twitter_consumer_key_urlencoded = twitter_consumer_key.stringByAddingPercentEscapesForQueryValue()
   static let twitter_consumer_secret_urlencoded = twitter_consumer_secret.stringByAddingPercentEscapesForQueryValue()
   
   static let twitter_token_request = twitter_consumer_key + ":" + twitter_consumer_secret
   static let twitter_token_request_encoded = twitter_token_request.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

   
   
   // Base64 encode UTF 8 string
   // fromRaw(0) is equivalent to objc 'base64EncodedStringWithOptions:0'
   // Notice the unwrapping given the NSData! optional
   // NSString! returned (optional)

   var window: UIWindow?


   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      // Override point for customization after application launch.
      return true
   }

   func applicationWillResignActive(application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   }

   func applicationWillEnterForeground(application: UIApplication) {
      // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }


}

extension String {
   
   /// Percent escape value to be added to a URL query value as specified in RFC 3986
   ///
   /// This percent-escapes all characters except the alphanumeric character set and "-", ".", "_", and "~".
   ///
   /// http://www.ietf.org/rfc/rfc3986.txt
   ///
   /// :returns: Return precent escaped string.
   
   func stringByAddingPercentEscapesForQueryValue() -> String? {
      let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
      characterSet.addCharactersInString("-._~")
      return stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
   }
}

