
import os
import UIKit

final class TaskCreateView: UIView
{
    var didClickClose: ()->() = { os_log("You clicked close. Override this handler.") }
    var didClickSave: (Tasklist)->() = { tasklist in os_log("You clicked save. Override this handler.") }
 
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
    
    let taskTitleInputView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
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
    }
    
    func setButtonIsEnabled(isEnabled: Bool){
        saveButton.isEnabled = isEnabled
        saveButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    @objc func didSave(){
        tasklist.flatMap { didClickSave($0) }
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
        setButtonIsEnabled(isEnabled: false)
        backgroundColor = UIColor(hexString: "#fffeff")
        addSubview(closeButton)
        addSubview(taskTitleInputView)
        addSubview(bottomStrip)
        bottomStrip.addSubview(separatorLine)
        bottomStrip.addSubview(taskListLabel)
        bottomStrip.addSubview(saveButton)
        
        let views = enumerateSubViews()
        views.values.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        [
            "H:[closeButton(16)]-10-|",
            "V:|-10-[closeButton(16)]",
            "H:|-[taskTitleInputView]-|",
            "H:|[separatorLine]|",
            "V:|[separatorLine(1)]",
            "H:|[bottomStrip]|",
            "V:|-38-[taskTitleInputView][bottomStrip(48)]",
            "H:|-10-[taskListLabel]-20-[saveButton(60)]-10-|",
            "V:[saveButton]-|"
            ].forEach {
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: views))
        }
        NSLayoutConstraint.activate([bottomStrip.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
        taskListLabel.centerVerticallyInParent()
    }
}
