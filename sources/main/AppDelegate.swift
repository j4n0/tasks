
import os
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow? 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if ProcessInfo.processInfo.arguments.contains("StartFromCleanSlate") {
            environment.removeAuthentication()
        }
        window = UIWindow()
        window?.rootViewController = environment.coordinator.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
