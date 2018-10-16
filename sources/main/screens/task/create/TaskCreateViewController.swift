
import os
import UIKit

class TaskCreateViewController: UIViewController, Interactable
{
    // Interactable
    typealias Output = TaskCreateViewEvent
    var output: ((TaskCreateViewEvent) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    let taskCreateView = TaskCreateView()
    lazy var keyboard = KeyboardAvoidance(viewController: self)
    
    override func loadView() {
        view = taskCreateView
        taskCreateView.didClickClose = {
            self.output(.dismiss)
        }
        taskCreateView.didClickSave = { text, tasklist in
            self.output(.save(tasks: text, tasklist: tasklist))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output(.viewIsReady)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        keyboard.observeKeyboard()
        taskCreateView.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboard.stopObservingKeyboard()
    }
}
