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
    
    //var taskArray:[TaskModel] = []
    
    var baseArray: [[TaskModel]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date1 = Date.from(year: 2014, month: 2, day: 20)
        let date2 = Date.from(year: 2014, month: 10, day: 21)
        let date3 = Date.from(year: 2014, month: 11, day: 23)
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, completed: false)
        let task3 = TaskModel(task: "Gym", subTask: "Running", date: date3, completed: false)
        
        let taskArray = [task1, task2, task3]
        let completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
        baseArray = [taskArray, completedArray]
        
        
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //func sortByDate(taskOne:TaskModel, taskTow:TaskModel) -> Bool {
            
       //    return taskOne.date.timeIntervalSince1970 < taskTow.date.timeIntervalSince1970
       // }
        
       // taskArray = taskArray.sorted(sortByDate)
        
        baseArray[0] = baseArray[0].sorted{(taskOne:TaskModel, taskTow:TaskModel) -> Bool in
            return taskOne.date.timeIntervalSince1970 < taskTow.date.timeIntervalSince1970

        }
        
        
        
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
            let thisTask = self.baseArray[indexPath!.section][indexPath!.row]
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return baseArray.count
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseArray[section].count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        var thisTask = baseArray[indexPath.section][indexPath.row]
        
        
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
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
            baseArray[1].append(newTask)
        }else {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
            baseArray[0].append(newTask)
        }
        
        
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
 
        self.tableView.reloadData()
        
    }


}

