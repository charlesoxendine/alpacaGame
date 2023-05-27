//
//  Manager.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/27/23.
//

import Foundation

struct Manager {
    var managerType: ManagerType!
    var level: Int!
    var managerName: String?
    
    init(managerType: ManagerType!, level: Int!, managerName: String? = nil) {
        self.managerType = managerType
        self.level = level
        self.managerName = managerName
    }
}

enum ManagerType {
    case processing
    case breeding
    case shipping
}
