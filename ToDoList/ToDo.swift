//
//  ToDo.swift
//  ToDoList
//
//  Created by Isaac Ballas on 12/19/18.
//  Copyright © 2018 Isaac Ballas. All rights reserved.
//
import UIKit
import Foundation

struct ToDo {
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    var notes: String?
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    // Method that retrieves array of items stored on the disk, and returns them if the disk contains items.
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    // Populate array
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isCompleted: true, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isCompleted: false, dueDate: Date(), notes: "Notes 2")
        return[todo1, todo2]
    }
}
