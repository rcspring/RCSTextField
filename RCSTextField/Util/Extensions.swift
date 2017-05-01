//
//  Extensions.swift
//  RCSTextField
//
//  Created by Ryan Spring on 5/1/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle(for: RCSTextField.self), value: "", comment: "")
    }
}
