//
//  Todo.swift
//  VaporApp
//
//  Created by Fatih Nayebi on 2017-01-03.
//
//

import Vapor
import Fluent
import Foundation



final class Todo: Model {
    var id: Node?
    var todoId: Int
    var name: String
    var description: String
    var notes: String
    var completed: Bool
    var synced: Bool
    var dueDate: Date
    var startingDate: Date
    
    var exists: Bool = false
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        todoId = try node.extract("todoId")
        name = try node.extract("name")
        description = try node.extract("description")
        notes = try node.extract("notes")
        completed = try node.extract("completed")
        synced = try node.extract("synced")
        dueDate = try node.extract("dueDate", transform: Todo.dateFromString)!
        startingDate = try node.extract("startingDate", transform: Todo.dateFromString)!
    }
    
    init(todoId: Int, name: String, description: String, notes: String, completed: Bool, synced: Bool, dueDate: Date, startingDate: Date) {
        self.todoId = todoId
        self.name = name
        self.description = description
        self.notes = notes
        self.completed = completed
        self.synced = synced
        self.dueDate = dueDate
        self.startingDate = startingDate
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "todoId": todoId,
            "name": "\(name)",
            "description": "\(description)",
            "notes": "\(notes)",
            "completed": completed,
            "synced": synced,
            "dueDate": Todo.dateToString(dueDate),
            "startingDate": Todo.dateToString(startingDate)
            ])
        
    }
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}

extension Todo: NodeConvertible {

}


extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}


extension Todo {
    static func dateFromString(_ dateAsString: String?) -> Date? {
        guard let string = dateAsString else { return nil }
        
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.date(from: string)
        return val
    }
    
    static func dateToString(_ dateIn: Date?) -> String? {
        guard let date = dateIn else { return nil }
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.string(from: date)
        return val
    }
}


final class Login: Model {
    var id: Node?
    var userName: String
    var password: String
    
    
    var exists: Bool = false
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        userName = try node.extract("userName")
        password = try node.extract("password")
        
    }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
        
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "userName": "\(userName)",
            "password": "\(password)",
            
            ])
        
    }
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}

extension Login: NodeConvertible {
    
}

