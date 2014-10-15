//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by yousheng chang on 10/11/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var taskDetailModel:TaskModel!
    
    
    
    @IBOutlet var taskTextField: UITextField!
    @IBOutlet var subtaskTextField: UITextField!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.taskTextField.text = taskDetailModel.task
        self.subtaskTextField.text = taskDetailModel.subTask
        self.dueDatePicker.date = taskDetailModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        taskDetailModel.task = taskTextField.text
        taskDetailModel.subTask = subtaskTextField.text
        taskDetailModel.date = dueDatePicker.date
        taskDetailModel.completed = taskDetailModel.completed
        
        appDelegate.saveContext()
        
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
