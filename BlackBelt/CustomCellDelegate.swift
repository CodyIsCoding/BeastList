//
//  CustomCellDelegate.swift
//  BlackBelt
//
//  Created by Cody LaRont on 11/18/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import Foundation

protocol CustomCellDelegate: class {
    func beastButtonWasPressed(sender: CustomCell)
    func editButtonWasPressed(sender: CustomCell)
}
