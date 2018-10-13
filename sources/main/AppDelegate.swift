import UIKit

var environment: Environment = AppEnvironment()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var appFlowController: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appFlowController = AppCoordinator()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appFlowController
        window?.makeKeyAndVisible()
        appFlowController.start()
        return true
    }
    
    func applicationWillResignActive    (_ application: UIApplication) {}
    func applicationDidEnterBackground  (_ application: UIApplication) {}
    func applicationWillEnterForeground (_ application: UIApplication) {}
    func applicationDidBecomeActive     (_ application: UIApplication) {}
    func applicationWillTerminate       (_ application: UIApplication) {}
}
