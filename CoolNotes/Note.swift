//
//  Note+CoreDataClass.swift
//  CoolNotes
//
//  Created by Gaurav Saraf on 1/2/17.
//  Copyright © 2017 Gaurav Saraf. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

//@objc(Note)
public class Note: NSManagedObject {

    convenience init(text: String = "New Note", context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Note", in: context) {
            self.init(entity: ent, insertInto: context)
            self.text = text
            self.creationDate = Date()
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
    var humanReadableAge: String{
        get{
            let fmt = DateFormatter()
            fmt.timeStyle = .none
            fmt.dateStyle = .short
            fmt.doesRelativeDateFormatting = true
            fmt.locale = NSLocale.current
            return fmt.string(from: creationDate!)
        }
    }
}
