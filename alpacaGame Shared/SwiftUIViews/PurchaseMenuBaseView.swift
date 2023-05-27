//
//  PurchaseMenuBaseView.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/26/23.
//

import SwiftUI

struct PurchaseMenuBaseView: View {
    @State var purchaseMenuTitle: String! = ""
    @State var purchasableObject: [PurchasableItem] = []
    @State private var showingAlert = false
    
    @State private var currentlySelectedItem: PurchasableItem?
    @State private var currentMoney: String! = "$0.00"
    
    init(purchaseMenuTitle: String!, objectsToPurchase: [PurchasableItem]? = []) {
        _purchaseMenuTitle = State(initialValue: purchaseMenuTitle)
        _purchasableObject = State(initialValue: objectsToPurchase ?? [])
        self.currentMoney = GameManager.shared.getMoneyValue()
    }
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 30)
            VStack {
                Text(purchaseMenuTitle)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Text(currentMoney)
            }
            Spacer(minLength: 10)
            ForEach(purchasableObject, id: \.itemName) { object in
                Spacer(minLength: 20)
                HStack {
                    Text(object.itemName)
                    Text(GameManager.getMoneyValue(value: object.itemCost))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .onTapGesture {
                    currentlySelectedItem = object
                    showingAlert = true
                }
            }
        }.alert("Are you sure you want to purchase \(currentlySelectedItem?.itemName ?? "")?", isPresented: $showingAlert) {
            Button("Purchase", role: .none) {
                //TODO: MAKE THE PURCHASE
                guard let itemType = currentlySelectedItem?.purchasableItemType else {
                    return
                }
                
                switch itemType {
                case .residental:
                    print("")
                case .breedingManager:
                    print("")
                case .processingManager:
                    print("")
                case .food:
                    print("")
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct PurchaseMenuBaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseMenuBaseView(purchaseMenuTitle: "Food", objectsToPurchase: [PurchasableItem(itemName: "Test3", itemCost: 1500.00, purchasableItemType: .food), PurchasableItem(itemName: "Test", itemCost: 10.00, purchasableItemType: .residental), PurchasableItem(itemName: "Test2", itemCost: 15.00, purchasableItemType: .processingManager), PurchasableItem(itemName: "Test1", itemCost: 2900.50, purchasableItemType: .breedingManager)])
            .previewInterfaceOrientation(.landscapeRight)
    }
}

enum PurchaseMenuType: String {
    case food = "Food"
    case residential = "Alpaca Housing"
    case managers = "Managers"
}
