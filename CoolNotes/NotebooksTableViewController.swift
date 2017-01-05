//
//  NotebooksTableViewController.swift
//  CoolNotes
//
//  Created by Gaurav Saraf on 1/3/17.
//  Copyright © 2017 Gaurav Saraf. All rights reserved.
//

import UIKit
import CoreData

class NotebooksTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CoolNotes"
        
        // Get the Stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create the fetch request
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the FetchResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewNotebook(_ sender: Any) {
        let nb = Notebook(name: "New Notebook", context: fetchedResultsController!.managedObjectContext)
        print("Just created a notebook: \(nb)")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Find the notebook
        let nb = fetchedResultsController!.object(at: indexPath) as! Notebook
        
        // Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotebookCell", for: indexPath)
        
        // Sync notebook -> cell
        cell.textLabel?.text = nb.name
        cell.detailTextLabel?.text = "(\(nb.notes!.count) notes"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayNote" {
            if let notesVC = segue.destination as? NotesViewController {
                
                // Create Fetch Request
                let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false),
                                      NSSortDescriptor(key: "text", ascending: true)]
                
                let indexPath = tableView.indexPathForSelectedRow!
                let nb = fetchedResultsController?.object(at: indexPath) as! Notebook
                
                let predicate = NSPredicate(format: "notebook = %@", [nb])
                fr.predicate = predicate
                
                // Create FetchResultsController
                let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                // Inject it into the notesVC
                notesVC.fetchedResultsController = fc
                
                notesVC.notebook = nb
            }
        }
    }

}
