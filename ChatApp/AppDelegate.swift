//
//  AppDelegate.swift
//  ChatApp
//
//  Created by kashee on 11/07/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        handleUpcomingEvent()
        
        let vc = VCLogin()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func handleUpcomingEvent(){
        
        var ref = DatabaseReference()
        ref = Database.database().reference()

        var listOfChatInfo = [Chat]()
        
        ref.child("chat").queryOrdered(byChild: "postData").observe(.value, with:
            { (snapshot) in

                listOfChatInfo.removeAll()
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapshot{
                        if let postData = snap.value as? [String:Any]{
                            let username = postData["name"] as? String
                            let text = postData["text"] as? String
                            
                            var postDate:CLong?
                            if let postDateIn = postData["postData"] as? CLong{
                                postDate = postDateIn
                            }
                            
                            listOfChatInfo.append(Chat(userName: username!, description: text!, datePost: "\(postDate)"))
                            
                        }
                    }
                let val = ["value":listOfChatInfo]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leave"), object: nil, userInfo: val)
                    
                    // print("Snapshot value: \(snapshot)")
                }
        })
        
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

