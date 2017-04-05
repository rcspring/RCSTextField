//
//  RCSTextField.swift
//  shopper
//
//  Created by Ryan Spring on 3/31/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

protocol RCSUnitTextFieldDelegate {
    func textFieldDidComplete(field:RCSUnitTextField)
    func textFieldValueDidChange(field:RCSUnitTextField)
}


class RCSUnitTextField : UITextField, UITextFieldDelegate {
    
    var measUnit : Unit = UnitMass.kilograms {
        didSet {
        
        }
    }
    var dismissButtonColor = UIColor.blue
    var unitDelegate : RCSUnitTextFieldDelegate?
    var measurement : Measurement<Unit>
    
    private var unitString : String
    private var suffixString : String
    static let nForm = NumberFormatter()

    required init?(coder aDecoder: NSCoder) {
        unitString = measUnit.symbol
        suffixString = " " + unitString
        measurement = Measurement(value: 0.0, unit: measUnit)
    
        super.init(coder: aDecoder)
        
        super.keyboardType = .decimalPad
        super.textAlignment = .right
        
        super.inputAccessoryView = dismissButton()
        
        text = text! + suffixString
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

//    //MARK:- TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textL = textField.text else {
            return true
        }
        
        if range.location + range.length > textL.characters.count - suffixString.characters.count {
            textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
            return false
        }
        
        let newString = (textL as NSString).replacingCharacters(in: range, with: string)
        
        setMeasurement(value:newString)
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        unitDelegate?.textFieldDidComplete(field:self)
    }
    
    //MARK:- Private Methods
    private func pointRangeFromEnd(offset offsetVal:Int)->UITextRange? {
        let endPos = position(from: endOfDocument, offset: offsetVal)!
        return textRange(from: endPos, to: endPos)
    }
    
    private func dismissButton()->UIView {
        let button = UIButton()
        button.setTitle("DISMISS_DEFAULT_BUTTON", for: .normal)
        button.addTarget(self, action: #selector(RCSUnitTextField.buttonPushed(_:)), for: .touchUpInside)
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
    
    private func setMeasurement(value:String?) {
        guard let textL = value  else {
            measurement = Measurement(value: 0.0, unit: measUnit)
            return
        }
        
        
        let suffixBeginIdx = textL.characters.index(textL.endIndex, offsetBy: -suffixString.characters.count)
        let measurementQuantity = textL.substring(to: suffixBeginIdx)
        
        if measurementQuantity.characters.count == 0 {
            measurement = Measurement(value: 0.0, unit: measUnit)
            return
        }
        
        let number = RCSUnitTextField.nForm.number(from: measurementQuantity)!
        measurement = Measurement(value: number.doubleValue, unit: measUnit)
        unitDelegate?.textFieldValueDidChange(field: self )
    }
    
    
}

