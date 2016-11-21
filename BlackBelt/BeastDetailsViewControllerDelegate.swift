//
//  BeastDetailsViewControllerDelegate.swift
//  BlackBelt
//
//  Created by Cody LaRont on 11/18/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import Foundation

protocol BeastDetailsViewControllerDelegate: class {
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishAddingBeast beast: String)
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishEditingBeast beast: Beast)
}
