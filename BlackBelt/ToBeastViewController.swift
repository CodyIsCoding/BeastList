//
//  ViewController.swift
//  BlackBelt
//
//  Created by Cody LaRont on 11/18/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import UIKit
import CoreData

class ToBeastViewController: UITableViewController, CancelButtonDelegate, BeastDetailsViewControllerDelegate, CustomCellDelegate, BeastedViewControllerDelegate {
    var whatIWant = 0
    var beasts = [Beast]()
    var count = 0
    var check = 0
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    weak var delegate: BeastedViewControllerDelegate?
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        count += 1
        performSegueWithIdentifier("BeastDetails", sender: UIBarButtonItem.self)
    }
    
    func editButtonWasPressed(cell: CustomCell) {
        check += 1
        let index = tableView.indexPathForCell(cell as UITableViewCell)?.row
        // the important memory that we want to take a closer look at will be found at this index
        whatIWant = index!
        performSegueWithIdentifier("BeastDetails", sender: self)
    }
    
    func beastButtonWasPressed(cell: CustomCell) {
        let index = tableView.indexPathForCell(cell as UITableViewCell)?.row
        // the important memory that we want to take a closer look at will be found at this index
        whatIWant = index!
        let newBeasted = NSEntityDescription.insertNewObjectForEntityForName("Beasted", inManagedObjectContext: managedObjectContext) as! Beasted
        newBeasted.title = beasts[whatIWant].title
        newBeasted.timeStamp = NSDate()
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        let object = beasts[whatIWant]
        managedObjectContext.deleteObject(object)
        beasts.removeAtIndex(whatIWant)
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("\(error)")
        }
        performSegueWithIdentifier("Beasted", sender: self)
        tableView.reloadData()
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if count == 1 {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! BeastDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            count = 0
        } else if check == 1 {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! BeastDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            controller.beastToEdit = beasts[whatIWant] as! Beast
            check = 0
        }
    }
    
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishAddingBeast beast: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let newBeast = NSEntityDescription.insertNewObjectForEntityForName("Beast", inManagedObjectContext: managedObjectContext) as! Beast
        newBeast.title = beast
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllBeasts()
        tableView.reloadData()
    }
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishEditingBeast beast: Beast) {
        dismissViewControllerAnimated(true, completion: nil)
        if beast.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllBeasts()
        tableView.reloadData()
    }
    
    func beastedViewController(controller: BeastedViewController, didFinishAddingBeasted beasted: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let newBeasted = NSEntityDescription.insertNewObjectForEntityForName("Beasted", inManagedObjectContext: managedObjectContext) as! Beasted
        newBeasted.title = beasted
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllBeasts()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        cell.buttonDelegate = self
        cell.customCellLabel.text = beasts[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let object = beasts[indexPath.row]
        managedObjectContext.deleteObject(object)
        beasts.removeAtIndex(indexPath.row)
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("\(error)")
        }
        fetchAllBeasts()
        tableView.reloadData()
    }
    
    func fetchAllBeasts() {
        let userRequest = NSFetchRequest(entityName: "Beast")
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            beasts = results as! [Beast]
        } catch {
            print("\(error)")
        }
    }

    override func viewDidLoad() {
        fetchAllBeasts()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

