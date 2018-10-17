
import os
import UIKit

class TaskCreateViewController: UIViewController, Interactable
{
    // Interactable
    typealias Output = TaskCreateViewEvent
    var output: ((TaskCreateViewEvent) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    let titleEditViewController = TitleEditViewController()
    let taskCreateView = TaskCreateView()
    lazy var keyboard = KeyboardAvoidance(viewController: self)
    
    override func loadView() {
        view = taskCreateView
        taskCreateView.didClickClose = {
            self.output(.dismiss)
        }
        taskCreateView.didClickSave = { tasklist in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                let text = self.titleEditViewController.titleEditController.rows.compactMap {
                    return $0.title.isEmpty ? nil : $0.title
                    }.joined(separator: "\n")
                if !text.isEmpty {
                    self.output(.save(tasks: text, tasklist: tasklist))
                }
            })
        }
        titleEditViewController.titleEditController.addObserver(self, forKeyPath: #keyPath(TitleEditController.isValidData), options: [.initial, .new], context: nil)
        
        addChild(titleEditViewController)
        taskCreateView.taskTitleInputView.addSubview(titleEditViewController.view)
        titleEditViewController.view.pinEdgesToSuperview()
        titleEditViewController.didMove(toParent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output(.viewIsReady)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            self.keyboard.observeKeyboard()
            self.titleEditViewController.beginEditing()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboard.stopObservingKeyboard()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(TitleEditController.isValidData) {
            if let dic = change, let value = dic[NSKeyValueChangeKey.newKey] as? NSNumber {
                taskCreateView.setButtonIsEnabled(isEnabled: value.boolValue)
            }
        }
    }
}
