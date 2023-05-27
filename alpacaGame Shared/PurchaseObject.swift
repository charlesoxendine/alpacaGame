//
//  PurchaseObject.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/26/23.
//

import Foundation

struct PurchasableItem {
    var itemName: String!
    var itemDescription: String?
    var itemCost: Float!
    
    init(itemName: String!, itemDescription: String? = nil, itemCost: Float!) {
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemCost = itemCost
    }
}
