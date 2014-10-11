//
//  Date.swift
//  TaskIt
//
//  Created by yousheng chang on 10/11/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import Foundation

class Date {
    class func from (#year:Int, month:Int, day:Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalenda = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date = gregorianCalenda.dateFromComponents(components)
        
        return date!
        
        
    }
    
    class func toString (#date:NSDate) ->String {
        
        var dateStringFormatter = NSDateFormatter()
        
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        
        return dateString
        
        
    }
}
