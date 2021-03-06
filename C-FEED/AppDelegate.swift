 //
//  AppDelegate.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/2/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   

   var window: UIWindow?


   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      // Override point for customization after application launch.
      
      // initialize the Fabric API structure
      Twitter.sharedInstance().startWithConsumerKey("UhloQwuJ87ZdyBhQxKrdhSZai", consumerSecret: "pzqkvjfZvIPgh6UiF38uEp7ySlkYQwq0Dn7nitycowhnXoOynj")

      TwitterService.sharedInstance().setKeys(consumer_key: "UhloQwuJ87ZdyBhQxKrdhSZai", consumer_secret: "pzqkvjfZvIPgh6UiF38uEp7ySlkYQwq0Dn7nitycowhnXoOynj")
      
      Fabric.with([Twitter()])
      
      // Set all future tweet views to use dark theme using UIAppearanceProxy
      TWTRTweetView.appearance().theme = .Dark

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

