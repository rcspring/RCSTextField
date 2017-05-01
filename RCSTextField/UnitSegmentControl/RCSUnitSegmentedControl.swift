//
//  RCSUnitSegmentedControl.swift
//  RCSTextField
//
//  Created by Ryan Spring on 4/8/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

public protocol RCSUnitSegmentedControlDelegate: AnyObject {
    func dataModel() -> [(String, Dimension?)]
    func new(unit: Dimension?, idx: Int, onSegmentedControl: RCSUnitSegmentedControl)
}

public extension RCSUnitSegmentedControlDelegate {
    func dataModel() -> [(String, Dimension?)] {
        return [("Mass", UnitMass.shortTons), ("Volume", UnitVolume.gallons)]
    }
    func new(unit: Dimension?, idx: Int, onSegmentedControl: RCSUnitSegmentedControl) {}
}

public class RCSUnitSegmentedControl: UISegmentedControl {

    var dataModel: [(String, Dimension?)] = [] {
        didSet {
            configureForDataModel()
        }
    }

    @IBOutlet var IBdelegate: AnyObject? {
        get {
            return shadowDelegate as AnyObject
        }
        set {
            if let IBdelegateL = newValue as? RCSUnitSegmentedControlDelegate {
                shadowDelegate = IBdelegateL
            } else {
                shadowDelegate = nil
            }
        }
    }
    private weak var shadowDelegate: RCSUnitSegmentedControlDelegate?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(segmentChanged(sender:)), for: .valueChanged)
    }

    public override func awakeFromNib() {
        if let dataModelL = shadowDelegate?.dataModel() {
            dataModel = dataModelL
        }
    }

    func segmentChanged(sender: UISegmentedControl) {
        shadowDelegate?.new(unit: dataModel[sender.selectedSegmentIndex].1, idx: sender.selectedSegmentIndex,
              onSegmentedControl: self)
    }

    // MARK: Private Methods
    private func configureForDataModel() {
        removeAllSegments()

        for item in dataModel.enumerated() {
            insertSegment(withTitle: item.1.0, at: item.0, animated: false)
        }

    }
}
