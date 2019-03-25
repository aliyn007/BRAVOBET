//
//  AppDelegate.swift
//  BRAVOBET
//
//  Created by Александр on 10/9/18.
//  Copyright © 2018 Aleksandr ILIN. All rights reserved.
//


import UIKit
import Parse
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       // let userInfo = notification.request.content.userInfo as! [String: Any]
        
        
        
        completionHandler([.alert, .badge, .sound])
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    
        
      //  UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
     //   UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
    //    UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
     //   UINavigationBar.appearance().isTranslucent = true
        
       
        
       
        //Basketball.registerSubclass()
       // Soccer.registerSubclass()
       // Comment.registerSubclass()
       // Tennis.registerSubclass()
       // InfoMy.registerSubclass()
        let configuration = ParseClientConfiguration {
            $0.applicationId = "czY3TpsIWTubEXRmcL6anPHYCYU7fA2HoS2a0GFZ"
            $0 .clientKey = "YD2b6KDHF57yhajLuSLS6gH7qEtedM2Jw8jJmUUD"
            $0.server = "https://parseapi.back4app.com"
           // $0.isLocalDatastoreEnabled = true
            
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay ]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    
        // let defaultACL = PFACL()
       //PFUser.enableAutomaticUser()
        //PFUser.enableRevocableSessionInBackground()
       // PFUser.registerSubclass()
        
            Comment.registerSubclass()
        Parse.initialize(with: configuration)
        // PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
       // if (FBSDKAccessToken.current() != nil) { } 
        return true
    }
   
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        createInstallationOnParse(deviceTokenData: deviceToken)
    }
    
    
    
    func createInstallationOnParse(deviceTokenData:Data){
      if let installation = PFInstallation.current(){
        installation.setDeviceTokenFrom(deviceTokenData)
        installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully saved your push installation to Back4App!")
                } else {
                    if let myError = error{
                        print("Error saving parse installation \(myError.localizedDescription)")
                    }else{
                        print("Uknown error")
                    }
                }
            }
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
            })
        }
    }
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    private func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL?, sourceApplication: sourceApplication, annotation: annotation)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        //FBSDKAppEvents.activateApp()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0
        FBSDKAppEvents.activateApp()
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }
    
}
