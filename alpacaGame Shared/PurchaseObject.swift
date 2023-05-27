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
    var purchasableItemType: PurchasableItemType!
    var timeInEffect: Int? // not implemented yet but eventually in seconds
    
    init(itemName: String!, itemDescription: String? = nil, itemCost: Float!, purchasableItemType: PurchasableItemType) {
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemCost = itemCost
        self.purchasableItemType = purchasableItemType
    }
}

enum PurchasableItemType {
    case residental
    case food
    case processingManager
    case breedingManager
}
