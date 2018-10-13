
import os
import UIKit

// Set true to attempt to read the API key and company from a plist configuration file
private let useConfiguration = false

var environment: Environment = {
    let configuration: Configuration? = useConfiguration ? PlistConfiguration(forResource: "configuration", ofType: "plist") : nil
    let env = AppEnvironment(configuration: configuration)
    return env
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        processLaunchArguments()
        window = UIWindow()
        window?.rootViewController = environment.coordinator.navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func processLaunchArguments(){
        if ProcessInfo.processInfo.arguments.contains("StartFromCleanSlate") {
            // remove persistence and reinitialize the environment without configuration
            environment.store.removeEverything()
            environment = AppEnvironment(authentication: nil)
        }
    }
}
