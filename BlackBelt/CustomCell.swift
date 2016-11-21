//
//  CustomCell.swift
//  BlackBelt
//
//  Created by Cody LaRont on 11/18/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    var buttonDelegate: CustomCellDelegate?
    
    @IBOutlet weak var customCellLabel: UILabel!

    @IBAction func customCellButton(sender: UIButton) {
        buttonDelegate?.beastButtonWasPressed(self)
    }
    @IBAction func editButtonPressed(sender: UIButton) {
        buttonDelegate?.editButtonWasPressed(self)
    }
    
}
