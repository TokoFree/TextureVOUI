//
//  AppDelegate.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().isTranslucent = false
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func ad() {
        enum A {
            case foo
            case bar(Void)
        }
        
        let data: Void? = ()
//        data.map(A.foo)
        let x = A.foo
        let y = A.bar
        data.map(A.bar)
    }
}

//import UIKit
//
//protocol ShopReview: UIViewController {
//    func onContentLoaded()
//    func didTapProduct()
//
//    static func createPage(shopId: Int) -> ShopReview
//}
//
//class MyVC: UIViewController, ShopReview {
//    func onContentLoaded() {
//
//    }
//
//    func didTapProduct() {
//
//    }
//
//
//    static func
//}
