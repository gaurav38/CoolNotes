//
//  NotesViewController.swift
//  CoolNotes
//
//  Created by Gaurav Saraf on 1/3/17.
//  Copyright © 2017 Gaurav Saraf. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: CoreDataTableViewController {

    var notebook: Notebook?
    
    @IBAction func addNote(_ sender: Any) {
        if let nb = notebook, let context = fetchedResultsController?.managedObjectContext {
            let note = Note(text: "New Note", context: context)
            note.notebook = nb
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the note
        let note = fetchedResultsController?.object(at: indexPath) as! Note
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        // Sync note -> cell
        cell.textLabel?.text = note.text
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
