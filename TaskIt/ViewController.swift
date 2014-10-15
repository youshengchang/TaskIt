//
//  ViewController.swift
//  TaskIt
//
//  Created by yousheng chang on 10/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{

    @IBOutlet var tableView: UITableView!
    
    //var taskArray:[TaskModel] = []
    
    //var baseArray: [[TaskModel]] = []
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let date1 = Date.from(year: 2014, month: 2, day: 20)
        let date2 = Date.from(year: 2014, month: 10, day: 21)
        let date3 = Date.from(year: 2014, month: 11, day: 23)
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, completed: false)
        let task3 = TaskModel(task: "Gym", subTask: "Running", date: date3, completed: false)
        
        let taskArray = [task1, task2, task3]
        let completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
        baseArray = [taskArray, completedArray]
        */
        
        
        fetchResultsController = getFetchResultsController()
        fetchResultsController.delegate = self
        fetchResultsController.performFetch(nil)
        
        
        
        
        
        
        
        
        
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchResultsController.objectAtIndexPath(indexPath!) as TaskModel
            
            detailVC.taskDetailModel = thisTask
            
            
        }
        if segue.identifier == "showTaskAdd" {
            
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
                        
        }
        
    }
    
    @IBAction func taskAddButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
        
    }
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchResultsController.sections!.count
        
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections![section].numberOfObjects
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        var thisTask = fetchResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        cell.descriptionLabel.text = thisTask.subTask
        
        return cell
    }
    
    //UITableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
              return "To Do"
        }else{
             return "Completed"
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        
        if indexPath.section == 0 {
            thisTask.completed = true
        }else {
            thisTask.completed = false
        }
        
       (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        
    }
    
    //NSFetchResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
        
    }
    
    //Helper
    func taskFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let completeDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [completeDescriptor, sortDescriptor]
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchResultsController
        
    }


}

