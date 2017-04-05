//
//  RCSTextField.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

enum RCSTextFieldValue {
    case measurment(Measurement<Unit>)
    case quantity(Double)
    case nothing
}

protocol RCSTextFieldDelegate {
    func fieldDidComplete(field:RCSTextField)
    func fieldValueDidChange(field:RCSTextField)
}

struct RCSTextFieldConfiguration {
    var dismissButtonColor = UIColor.blue
    var quantityDelegate : RCSTextFieldDelegate?
    var dismissButtonText = "DISMISS_DEFAULT_BUTTON"
    var valueDelegate : RCSTextFieldDelegate?
    var measUnit : Unit = UnitMass.kilograms
}

class RCSTextField : UITextField, UITextFieldDelegate{
    
//    var dismissButtonColor = UIColor.blue
//    var quantityDelegate : RCSTextFieldDelegate?
//    var dismissButtonText = "DISMISS_DEFAULT_BUTTON"
    var configuration = RCSTextFieldConfiguration()
    public internal(set) var value : RCSTextFieldValue
    
    static let nForm = NumberFormatter()
 
    required init?(coder aDecoder: NSCoder) {
        value = .nothing
        super.init(coder: aDecoder)
        
        super.keyboardType = .decimalPad
        super.textAlignment = .right
        
        super.delegate = self
    }
    
    override var delegate: UITextFieldDelegate? {
        get {
            return nil
        }
        set {}
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(UIResponderStandardEditActions.cut(_:)):
            return false
        case #selector(UIResponderStandardEditActions.paste(_:)):
            return false
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        super.inputAccessoryView = dismissButton()
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {    
    }
    
    //MARK:- Private Methods
    private func dismissButton()->UIView {
        let button = UIButton()
        button.setTitle(configuration.dismissButtonText, for: .normal)
        button.addTarget(self, action: #selector(RCSQuantityTextField.buttonPushed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 375, height: 50)
        button.backgroundColor = configuration.dismissButtonColor
        
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: 375, height: 50)
        view.addSubview(button)
        
        return view
    }
    
    @objc private func buttonPushed(_ sender: Any) {
        self.resignFirstResponder()
    }


}
