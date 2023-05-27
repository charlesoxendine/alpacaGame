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
    
    init(purchaseMenuTitle: String!) {
        _purchaseMenuTitle = State(initialValue: purchaseMenuTitle)
    }
    
    var body: some View {
        List {
            Text(purchaseMenuTitle)
            ForEach(purchasableObject, id: \.itemName) { object in
                HStack {
                    Text("")
                }
            }
        }
    }
}

struct PurchaseMenuBaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseMenuBaseView(purchaseMenuTitle: "Food")
    }
}
