//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Isaac Ballas on 12/19/18.
//  Copyright © 2018 Isaac Ballas. All rights reserved.

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    func checkMarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isCompleted = !todo.isCompleted
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    // The VC will manage the model objects, so create the empty array,
    var todos: [ToDo] = []
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue cell")
        }
        // Get the model out of the array that corresponds to the cell being displayed
         // todos is the model array, and we use indexPath.row to grab the particular cell.
        let todo = todos[indexPath.row]
        // Update the cells properties, retrun the cell from the method.
        cell.titleLabel?.text = todo.title
        cell.isComplete.isSelected = todo.isCompleted
        cell.delegate = self
        return cell
    }
    
    // The next two methods are to delete cells.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete from array
        if editingStyle == .delete {
            todos.remove(at: indexPath.row) // Remove model object and this indexPaths row.
            // Delete from tableview
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    // MARK: - Navigation
     // This method is attached to the exit button, it transitions backwards to a segue.
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        // Verify saveUnwing is being called.
        guard segue.identifier == "saveUnwind" else { return }
        // Check if a model object exists in the segues source(the VC that triggered it)
        let sourceViewController = segue.source as! ToDoViewController
        // If the model above exists, add it to the array, then add a table cell that represents the data.
        if let todo = sourceViewController.todo {
            // If the model data unwrapes, you can unwrap the table view selectedIndexPath
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // If the selectedIndexPath has a value, use it to update the corresponding model and cell.
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else { // If the above does not work, append the model to the end of the collection and add a new cell.
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            // Downcast to the subclass
            let toDoViewController = segue.destination as! ToDoViewController
            // Use indexPath for selected row to access the corresponding model.
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = todos[indexPath.row]
            // Set the model property in the destination view controller.
            toDoViewController.todo = selectedToDo
        }
    }
} // End of class.
