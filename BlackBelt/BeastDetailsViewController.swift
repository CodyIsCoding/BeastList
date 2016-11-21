//
//  BeastDetailsViewController.swift
//  BlackBelt
//
//  Created by Cody LaRont on 11/18/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import UIKit
import CoreData

class BeastDetailsViewController: UIViewController {
    
    var beastToEdit: Beast?
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: BeastDetailsViewControllerDelegate?
    
    
    @IBOutlet weak var newBeastTextField: UITextField!
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if let beast = beastToEdit {
            beast.title = newBeastTextField.text!
            delegate?.beastDetailsViewController(self, didFinishEditingBeast: beast)
            print("1")
        } else {
            let beast = newBeastTextField.text!
            delegate?.beastDetailsViewController(self, didFinishAddingBeast: beast)
            print("2")
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    override func viewDidLoad() {
        if let beast = beastToEdit {
            newBeastTextField.text = beastToEdit?.title
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
