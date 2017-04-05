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


class RCSUnitTextField : RCSTextField {
    
    var measUnit : Unit = UnitMass.kilograms {
        didSet {
            zeroMeasurement()
        }
    }
//    var dismissButtonColor = UIColor.blue
//    var unitDelegate : RCSUnitTextFieldDelegate?
//    var dismissButtonText = "DISMISS_DEFAULT_BUTTON"
//    public private(set) var measurement : Measurement<Unit>
    
    private var unitString : String
    private var suffixString : String
//    static let nForm = NumberFormatter()

    required init?(coder aDecoder: NSCoder) {
        unitString = measUnit.symbol
        suffixString = " " + unitString

        super.init(coder: aDecoder)
        value = .measurment(Measurement(value: 0.0, unit: measUnit))
        
        text = text! + suffixString
    }
    
//    override var delegate: UITextFieldDelegate? {
//        get {
//            return nil
//        }
//        set {}
//    }
//    
//    
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        switch action {
//        case #selector(UIResponderStandardEditActions.cut(_:)):
//            return false
//        case #selector(UIResponderStandardEditActions.paste(_:)):
//            return false
//        default:
//            return super.canPerformAction(action, withSender: sender)
//        }
//    }

    //MARK:- TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textL = textField.text else {
            return true
        }
        
        if range.location + range.length > textL.characters.count - suffixString.characters.count {
            textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
            return false
        }
        
        let newString = (textL as NSString).replacingCharacters(in: range, with: string)
        
        setMeasurement(string:newString)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
    }
    
    //MARK:- Private Methods
    private func pointRangeFromEnd(offset offsetVal:Int)->UITextRange? {
        let endPos = position(from: endOfDocument, offset: offsetVal)!
        return textRange(from: endPos, to: endPos)
    }
    
    private func setMeasurement(string quantityString:String) {
    
        let suffixBeginIdx = quantityString.characters.index(quantityString.endIndex, offsetBy: -suffixString.characters.count)
        let measurementQuantity = quantityString.substring(to: suffixBeginIdx)
        
        if measurementQuantity.characters.count == 0 {
            value = .measurment(Measurement(value: 0.0, unit: measUnit))
            return
        }
        
        let number = RCSUnitTextField.nForm.number(from: measurementQuantity)!
        value = .measurment(Measurement(value: number.doubleValue, unit: measUnit))
        valueDelegate?.fieldValueDidChange(field: self)
    }
    
    private func zeroMeasurement() {
        unitString = measUnit.symbol
        suffixString = " " + unitString
        value = .measurment(Measurement(value: 0.0, unit: measUnit))
        
        text = suffixString
    }
    
    
}

