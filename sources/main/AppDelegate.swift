
import os
import UIKit

enum QuickActionIdentifier: String {
    case newTask
    init?(fullIdentifier: String) {
        guard let shortIdentifier = fullIdentifier.components(separatedBy: ".").last else {
            return nil
        }
        self.init(rawValue: shortIdentifier)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    let isRunningUITests = ProcessInfo.processInfo.arguments.contains("es.com.jano.tasks.tasksUITests")
    let isRunningUnitTests = ProcessInfo.processInfo.arguments.contains("es.com.jano.tasks.tasksTests")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if isRunningUITests {
            environment.removeAuthentication()
        } else if isRunningUnitTests {
            return true /* skips creating a controller */
        } else if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            handleQuickAction(shortcutItem)
            return false
        }

        window = UIWindow()
        window?.rootViewController = environment.coordinator.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleQuickAction(shortcutItem))
    }
    
    @discardableResult fileprivate func handleQuickAction(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        let shortcutType = shortcutItem.type
        guard let shortcutIdentifier = QuickActionIdentifier(fullIdentifier: shortcutType) else {
            return false
        }
        switch shortcutIdentifier {
        case .newTask:
            environment.coordinator.show(screens: [.taskList, .taskCreate])
        }
        return true
    }
}
