//
//  PurchasableItemsData.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/27/23.
//

import Foundation

class PurchasableItemsData {
    
    public func getManagersForSale() -> [PurchasableItem] {
        return [Processing_Manager, Breeding_Manager]
    }
    
    public func getHousingForSale() -> [PurchasableItem] {
        return [House_20, House_100, House_200]
    }
    
    public func getFoodForSale() -> [PurchasableItem] {
        return [Food_100, Food_300, Food_1000]
    }
    
    private let Processing_Manager = PurchasableItem(itemName: "Processing Manager",
                                                    itemCost: 1500,
                                                     purchasableItemType: .processingManager, quantity: 1)
    private let Breeding_Manager = PurchasableItem(itemName: "Husbandry Manager",
                                                    itemCost: 1500,
                                                   purchasableItemType: .breedingManager, quantity: 1)
    
    private let House_20 = PurchasableItem(itemName: "20 Residences",
                                           itemCost: (GameManager.shared.costPerResidence * 20),
                                           purchasableItemType: .residental, quantity: 20)
    private let House_100 = PurchasableItem(itemName: "100 Residences",
                                            itemCost: (GameManager.shared.costPerResidence * 100),
                                            purchasableItemType: .residental, quantity: 100)
    private let House_200 = PurchasableItem(itemName: "200 Residences",
                                           itemCost: (GameManager.shared.costPerResidence * 200),
                                            purchasableItemType: .residental, quantity: 200)
    
    private let Food_100 = PurchasableItem(itemName: "100 Food",
                                           itemCost: (GameManager.shared.foodCostPerItem * 100),
                                           purchasableItemType: .food, quantity: 100)
    private let Food_300 = PurchasableItem(itemName: "300 Food",
                                           itemCost: (GameManager.shared.foodCostPerItem * 300),
                                           purchasableItemType: .food, quantity: 300)
    private let Food_1000 = PurchasableItem(itemName: "1000 Food",
                                           itemCost: (GameManager.shared.foodCostPerItem * 1000),
                                            purchasableItemType: .food, quantity: 1000)
}
