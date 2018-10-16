
import os
import UIKit

class TaskCreateView: UIView
{
    var didClickClose: ()->() = { os_log("You clicked close. Override this handler.") }
    var didClickSave: (String, Tasklist)->() = { text, project in os_log("You clicked save. Override this handler.") }
 
    var tasklist: Tasklist? {
        willSet {
            taskListLabel.text = newValue?.name ?? ""
        }
    }
    
    let closeButton = UIButton(type: .custom).then {
        $0.addTarget(self, action: #selector(TaskCreateView.didClose), for: .touchUpInside)
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        $0.setImage(image, for: .normal)
        $0.adjustsImageWhenHighlighted = false
        $0.tintColor = UIColor(hexString: "#3973fd")
    }
    
    lazy var textField = UITextField().then {
        $0.placeholder = "Task title"
        $0.delegate = self
    }
    
    let separatorLine = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#e0e3e6")
    }
    
    let bottomStrip = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#f3f6f7")
    }
    
    let taskListLabel = UILabel().then {
        $0.text = ""
    }
    
    let saveButton = UIButton().then {
        $0.addTarget(self, action: #selector(TaskCreateView.didSave), for: .touchUpInside)
        $0.backgroundColor = UIColor(hexString: "#3973fd")
        $0.setTitle("  Save  ", for: .normal)
        $0.layer.cornerRadius = 16/2
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        TaskCreateView.setButtonIsEnabled(button: $0, isEnabled: false)
    }
    
    static func setButtonIsEnabled(button: UIButton, isEnabled: Bool){
        button.isEnabled = isEnabled
        button.alpha = isEnabled ? 1.0 : 0.5
    }
    
    @objc func didSave(){
        guard let text = textField.text, let tasklist = tasklist else {
            os_log("Clicked save but data was not ready.")
            return
        }
        didClickSave(text, tasklist)
    }
    
    @objc func didClose(){
        didClickClose()
    }
     
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("unavailable")
    }
    
    private func initialize()
    {
        backgroundColor = UIColor(hexString: "#fffeff")
        addSubview(closeButton)
        addSubview(textField)
        addSubview(bottomStrip)
        bottomStrip.addSubview(separatorLine)
        bottomStrip.addSubview(taskListLabel)
        bottomStrip.addSubview(saveButton)
        
        let views = enumerateSubViews()
        views.values.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        [
            "H:[closeButton(16)]-10-|",
            "V:|-10-[closeButton(16)]",
            "V:|-48-[textField(64)]",
            "H:|-[textField]-|",
            "H:|[separatorLine]|",
            "V:|[separatorLine(1)]",
            "H:|[bottomStrip]|",
            "V:[bottomStrip(48)]",
            "H:|-10-[taskListLabel]-20-[saveButton]-10-|",
            "V:[taskListLabel]-|",
            "V:[saveButton]-|"
            ].forEach {
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: views))
        }
        NSLayoutConstraint.activate([bottomStrip.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}

extension TaskCreateView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultingText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        let isValidText = resultingText.count > 0
        TaskCreateView.setButtonIsEnabled(button: saveButton, isEnabled: isValidText)
        return true
    }
}
