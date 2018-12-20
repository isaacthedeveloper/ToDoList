//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Isaac Ballas on 12/19/18.
//  Copyright © 2018 Isaac Ballas. All rights reserved.

import UIKit

class ToDoTableViewController: UITableViewController {
    // The VC will manage the model objects, so create the empty array,
    var todos: [ToDo] = []
    
    struct PropertyKeys {
        let ToDoCell = "ToDoCellIdentifier"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
    }
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Attempt to dequeue a cell, fail if unsuccesful.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.init().ToDoCell) else {
            fatalError("Could not dequeue cell")
        }
        // Get the model out of the array that corresponds to the cell being displayed
        let todo = todos[indexPath.row]
        // Update the cells properties, retrun the cell from the method.
        cell.textLabel?.text = todo.title
        return cell
    }
    
    // The next two methods are to delete cells.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete from array
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            // Delete from tableview
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        
    }
} // End of class.
