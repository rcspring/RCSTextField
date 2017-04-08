//
//  RCSTextField.swift
//  shopper
//
//  Created by Ryan Spring on 3/31/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

public protocol RCSUnitTextFieldDelegate : RCSTextFieldDelegate {
    func measUnitForTextField(field:RCSUnitTextField)->Unit
}

public extension RCSUnitTextFieldDelegate {
    func measUnitForTextField()->Unit {
        return UnitMass.shortTons
    }
}


public class RCSUnitTextField : RCSTextField {
    
    private var unitString : String
    private var suffixString : String
    
    public var measUnit : Unit = UnitMass.kilograms {
        didSet {
            zeroMeasurement()
        }
    }
    
    override public var valueDelegate: AnyObject? {
        get {
            return self.shadowUnitDelegate
        }
        set {
            if let newValueL = newValue as? RCSUnitTextFieldDelegate{
                shadowUnitDelegate = newValueL
            }
            else {
                shadowUnitDelegate = nil
            }
        }
    }
    private var shadowUnitDelegate: RCSUnitTextFieldDelegate?

    public required init?(coder aDecoder: NSCoder) {
        unitString = ""
        suffixString = " "

        super.init(coder: aDecoder)
        value = .measurment(Measurement(value: 0.0, unit: measUnit))
        
        unitString = measUnit.symbol
        suffixString = " " + unitString
        super.keyboardType = .decimalPad
    }
    
    //MARK:- TextField Delegate
    override public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let shadowUnitDelegateL = shadowUnitDelegate {
            measUnit = shadowUnitDelegateL.measUnitForTextField(field: self)
        }
        
        return super.textFieldShouldBeginEditing(textField)
    }
    
    
    override public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textL = textField.text else {
            return true
        }
        
        if textL.characters.count == 0 && string.characters.count > 0 {
            textField.text = suffixString
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
        
        if let textL = text, textL.isEmpty {
            text = suffixString
        }
        
        textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
    }
    
    override public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        shadowUnitDelegate?.fieldDidComplete(field: self)
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
            text = ""
            return
        }
        
        let number = RCSUnitTextField.nForm.number(from: measurementQuantity)!
        value = .measurment(Measurement(value: number.doubleValue, unit:measUnit))
        shadowUnitDelegate?.fieldValueDidChange(field: self)
    }
    
    private func zeroMeasurement() {
        unitString = measUnit.symbol
        suffixString = " " + unitString
        value = .measurment(Measurement(value: 0.0, unit: measUnit))
    }
}

