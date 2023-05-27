//
//  PurchaseMenuBaseView.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/26/23.
//

import SwiftUI

protocol PurchaseMenuBaseViewDelegate {
    func closeTapped()
}

struct PurchaseMenuBaseView: View {
    @State var purchaseMenuTitle: String! = ""
    @State var purchasableObject: [PurchasableItem] = []
    @State private var showingAlert = false
    
    @State private var currentlySelectedItem: PurchasableItem?
    @State private var currentMoney: String! = "$0.00"
    
    var delegate: PurchaseMenuBaseViewDelegate?
    
    init(purchaseMenuTitle: String!, objectsToPurchase: [PurchasableItem]? = []) {
        _purchaseMenuTitle = State(initialValue: purchaseMenuTitle)
        _purchasableObject = State(initialValue: objectsToPurchase ?? [])
        _currentMoney = State(initialValue: GameManager.shared.getMoneyValue())
    }
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 30)
            HStack{
                VStack {
                    Text(purchaseMenuTitle)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Text(currentMoney)
                }
                Button("Close") {
                    delegate?.closeTapped()
                }
                .tint(.black)
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
                guard let currentItem = currentlySelectedItem else {
                    return
                }
                
                switch currentItem.purchasableItemType {
                case .residental:
                    GameManager.shared.buyResidence(alpacaSpace: currentItem.quantity)
                case .breedingManager:
                    GameManager.shared.buyManager(managerType: .breeding)
                case .processingManager:
                    GameManager.shared.buyManager(managerType: .processing)
                case .food:
                    GameManager.shared.buyFood(amount: Float(currentItem.quantity))
                case .none:
                    print("tehee")// This shouldn't ever happen...right?
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct PurchaseMenuBaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseMenuBaseView(purchaseMenuTitle: "Food", objectsToPurchase: [PurchasableItem(itemName: "Test3", itemCost: 1500.00, purchasableItemType: .food, quantity: 19221), PurchasableItem(itemName: "Test", itemCost: 10.00, purchasableItemType: .residental, quantity: 4), PurchasableItem(itemName: "Test2", itemCost: 15.00, purchasableItemType: .processingManager, quantity: 912324233), PurchasableItem(itemName: "Test1", itemCost: 2900.50, purchasableItemType: .breedingManager, quantity: 19)])
            .previewInterfaceOrientation(.landscapeRight)
    }
}

enum PurchaseMenuType: String {
    case food = "Food"
    case residential = "Alpaca Housing"
    case managers = "Managers"
}
