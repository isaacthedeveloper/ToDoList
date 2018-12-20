//
//  ToDo.swift
//  ToDoList
//
//  Created by Isaac Ballas on 12/19/18.
//  Copyright © 2018 Isaac Ballas. All rights reserved.
//
import UIKit
import Foundation

struct ToDo: Codable {
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    var notes: String?
    // Path to Document DIrectory
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    // This method takes the date, and converts it to a string.
     // A Date object is time consuming to create, so make it a static method so that the object is created only once, and is not part of a instance of the model.
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    // Method that retrieves array of items stored on the disk, and returns them if the disk contains items.
    static func loadToDos() -> [ToDo]? {
        // Load data from the disk. Use PropertyListDecoder and the methods on Data to unarchive the data and return in.
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    // Encode a [ToDo] collection, then use to the write(to:options:) method on Data to store in Document Directory
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
    // Populate array with static data.
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isCompleted: true, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isCompleted: false, dueDate: Date(), notes: "Notes 2")
        // Dont forget to return the array.
        return[todo1, todo2]
    }
}
