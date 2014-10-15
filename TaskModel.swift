//
//  TaskModel.swift
//  TaskIt
//
//  Created by yousheng chang on 10/14/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subTask: String
    @NSManaged var task: String

}
