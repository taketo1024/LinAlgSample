//
//  UIViewExtensions.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/27.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = displayModeButtonItem
        guard let action = barButtonItem.action, let target = barButtonItem.target else { return }
        UIApplication.shared.sendAction(action, to: target, from: nil, for: nil)
    }
}

extension UIView {
}
