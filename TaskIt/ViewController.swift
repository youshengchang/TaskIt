//
//  ViewController.swift
//  TaskIt
//
//  Created by yousheng chang on 10/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var tableView: UITableView!
    
    var taskArray:[TaskModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date1 = Date.from(year: 2014, month: 2, day: 20)
        let date2 = Date.from(year: 2014, month: 10, day: 21)
        let date3 = Date.from(year: 2014, month: 11, day: 23)
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2)
        let task3 = TaskModel(task: "Gym", subTask: "Running", date: date3)
        taskArray = [task1, task2, task3]
        
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = self.taskArray[indexPath!.row]
            detailVC.taskDetailModel = thisTask
            detailVC.mainVC = self
            
        }
        if segue.identifier == "showTaskAdd" {
            
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
            
        }
        
    }
    
    @IBAction func taskAddButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
        
    }
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        var thisTask = taskArray[indexPath.row]
        
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        cell.descriptionLabel.text = thisTask.subTask
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    


}

