//
//  RCSTextField.swift
//  shopper
//
//  Created by Ryan Spring on 3/31/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

protocol RCSQuantityTextFieldDelegate {
    func quantityFieldDidComplete(field:RCSQuantityTextField)
    func quantityFieldValueDidChange(field:RCSQuantityTextField)
}


class RCSQuantityTextField : UITextField, UITextFieldDelegate {

    var dismissButtonColor = UIColor.blue
    var quantityDelegate : RCSQuantityTextFieldDelegate?
    var dismissButtonText = "DISMISS_DEFAULT_BUTTON"
    public private(set) var quantity : Double
    
    static let nForm = NumberFormatter()

    required init?(coder aDecoder: NSCoder) {
        quantity = 0.0
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

    //MARK:- TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textL = textField.text else {
            return true
        }
        
        let newString = (textL as NSString).replacingCharacters(in: range, with: string)
        setQuantity(value: newString)
    
        return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        super.inputAccessoryView = dismissButton()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        quantityDelegate?.quantityFieldDidComplete(field:self)
    }
    
    //MARK:- Private Methods
    private func pointRangeFromEnd(offset offsetVal:Int)->UITextRange? {
        let endPos = position(from: endOfDocument, offset: offsetVal)!
        return textRange(from: endPos, to: endPos)
    }
    
    private func dismissButton()->UIView {
        let button = UIButton()
        button.setTitle(dismissButtonText, for: .normal)
        button.addTarget(self, action: #selector(RCSQuantityTextField.buttonPushed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 375, height: 50)
        button.backgroundColor = dismissButtonColor
        
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: 375, height: 50)
        view.addSubview(button)
        
        return view
    }
    
    @objc private func buttonPushed(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    private func setQuantity(value:String?) {
        guard let textL = value, textL.characters.count > 0  else {
            quantity = 0.0
            return
        }
        
        let number = RCSQuantityTextField.nForm.number(from: textL)!
        quantity = number.doubleValue
        
        quantityDelegate?.quantityFieldValueDidChange(field: self )
    }
    
    private func zeroQuantity() {
        text = ""
    }
    
    
}

