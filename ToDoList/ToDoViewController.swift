//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Isaac Ballas on 12/19/18.
//  Copyright © 2018 Isaac Ballas. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // calculate 24 hours in the future.
        dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    var isPickerHidden = true
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButtonTapped: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    // MARK: - Table view data source
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [1,0]: // Due Date Cell
            return isPickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]: // Notes Cell
            return largeCellHeight
            
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [2,0]:
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }

    
    // MARK: Helper Methods
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButtonTapped.isEnabled = !text.isEmpty
    }
    func updateDueDateLabel(date: Date) {
        // Update the dueDate Label
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }

}
