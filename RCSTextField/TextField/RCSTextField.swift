//
//  RCSTextField.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit
import SnapKit

public enum RCSTextFieldValue {
    case measurment(Measurement<Unit>)
    case quantity(Double)
    case text(String)
    case nothing
}

public protocol RCSTextFieldDelegate: AnyObject {
    func fieldDidComplete(field: RCSTextField)
    func fieldValueDidChange(field: RCSTextField)
}

public extension RCSTextFieldDelegate {
    func fieldDidComplete(field: RCSTextField) {}
    func fieldValueDidChange(field: RCSTextField) {}
}

public class RCSTextField: UITextField, UITextFieldDelegate {

    public internal(set) var value: RCSTextFieldValue = .text("")

    @IBInspectable public var dismissButtonText: String = "DISMISS_DEFAULT_BUTTON".localized
    @IBInspectable public var dismissButtonColor: UIColor = UIColor.blue

    @IBOutlet public var valueDelegate: AnyObject? {
        get {
            return shadowDelegate
        }
        set {
            if let delegateValue = newValue {
                shadowDelegate = delegateValue as? RCSTextFieldDelegate
            } else {
                shadowDelegate = nil
            }
        }
    }

    weak var shadowDelegate: RCSTextFieldDelegate?

    static let nForm = NumberFormatter()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public override var delegate: UITextFieldDelegate? {
        get {
            return nil
        }
        set {}
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(UIResponderStandardEditActions.cut(_:)):
            return false
        case #selector(UIResponderStandardEditActions.paste(_:)):
            return false
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let confirmationView = dismissButton()
        super.inputAccessoryView = confirmationView

        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let textL = text else {
            return true
        }

        let newString = (textL as NSString).replacingCharacters(in: range, with: string)
        value = .text(newString)

        shadowDelegate?.fieldValueDidChange(field: self)
        return true
    }

    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        shadowDelegate?.fieldDidComplete(field: self)
    }

    // MARK: Private Methods
    private func dismissButton() -> UIView {
        let button = UIButton()
        button.setTitle(dismissButtonText, for: .normal)
        button.addTarget(self, action: #selector(RCSQuantityTextField.buttonPushed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: self.window!.bounds.width, height: 50)
        button.backgroundColor = dismissButtonColor

        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: self.window!.bounds.width, height: 50)
        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }

        return view
    }

    private func setup() {
        super.textAlignment = .left
        super.delegate = self
    }

    @objc private  func buttonPushed(_ sender: Any) {
        self.resignFirstResponder()
    }
}
