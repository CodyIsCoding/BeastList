//
//  BeastedViewController.swift
//  BlackBelt
//
//  Created by Cody LaRont on 11/18/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import UIKit
import CoreData

class BeastedViewController: UITableViewController {
    var whatIWant = 0
    
    var beasted = [Beasted]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastedCustomCell") as! BeastedCustomCell
        cell.titleLabel.text = beasted[indexPath.row].title
        let date = beasted[indexPath.row].timeStamp
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM d"
        cell.dateLabel.text = dateFormatter.stringFromDate(date!)
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasted.count
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let object = beasted[indexPath.row]
        managedObjectContext.deleteObject(object)
        beasted.removeAtIndex(indexPath.row)
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("\(error)")
        }
        fetchAllBeasted()
        tableView.reloadData()
    }
    
    func fetchAllBeasted() {
        let userRequest = NSFetchRequest(entityName: "Beasted")
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            beasted = results as! [Beasted]
        } catch {
            print("\(error)")
        }
    }
    
    override func viewDidLoad() {
        fetchAllBeasted()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
