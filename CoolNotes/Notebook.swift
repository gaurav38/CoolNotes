//
//  Notebook+CoreDataClass.swift
//  CoolNotes
//
//  Created by Gaurav Saraf on 1/2/17.
//  Copyright © 2017 Gaurav Saraf. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

//@objc(Notebook)
public class Notebook: NSManagedObject {
    
    convenience init(name: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Notebook", in: context) {
            self.init(entity: ent, insertInto: context)
            self.name = name
            self.creationDate = Date()
        } else {
            fatalError("Unable to find Entity name")
        }
    }

}
