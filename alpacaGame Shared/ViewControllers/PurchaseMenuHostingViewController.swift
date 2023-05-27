//
//  PurchaseMenuHostingViewController.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/27/23.
//

import UIKit
import SwiftUI

class PurchaseMenuHostingViewController: UIViewController {
    
    var swiftView: PurchaseMenuBaseView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setView(purchaseType: PurchaseMenuType) {
        let items = getPurchasableItems(purchaseType: purchaseType)
        swiftView = PurchaseMenuBaseView(purchaseMenuTitle: purchaseType.rawValue, objectsToPurchase: items)
        swiftView?.delegate = self
        let vc = UIHostingController(rootView: swiftView)
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false  
        
        addChild(vc)
        view.addSubview(swiftuiView)
        
        NSLayoutConstraint.activate([
            swiftuiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leftAnchor.constraint(equalTo: view.leftAnchor),
            swiftuiView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        vc.didMove(toParent: self)
    }
    
    func getPurchasableItems(purchaseType: PurchaseMenuType) -> [PurchasableItem] {
        let purchasableData = PurchasableItemsData()
        var itemsData: [PurchasableItem] = []
        
        switch purchaseType {
        case .food:
            itemsData = purchasableData.getFoodForSale()
        case .residential:
            itemsData = purchasableData.getHousingForSale()
        case .managers:
            itemsData = purchasableData.getManagersForSale()
        }
        
        return itemsData
    }
}

extension PurchaseMenuHostingViewController: PurchaseMenuBaseViewDelegate {
    func closeTapped() {
        self.dismiss(animated: true)
    }
}
