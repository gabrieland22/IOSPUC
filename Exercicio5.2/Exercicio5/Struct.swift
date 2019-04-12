//
//  Struct.swift
//  Exercicio5
//
//  Created by user151694 on 4/11/19.
//  Copyright © 2019 PUC. All rights reserved.
//

import Foundation


struct Todo: Codable, CustomDebugStringConvertible{
    var id: Int?
    var task: String
    var isCompleted: Bool
    init(task: String) {
        self.task = task
        self.isCompleted = false
    }
    
    enum CodingKeys: String, CodingKey{
        case id
        case task
        case isCompleted = "isCompleted"
    }
    
    var debugDescription: String {
        return "\n(\(task) - \(String(describing: id)))"
    }
}


