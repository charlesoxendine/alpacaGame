//
//  StoreViewController.swift
//  alpacaGame iOS
//
//  Created by Charlie Oxendine on 5/12/23.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    
    let gameManager = GameManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        self.moneyLabel.text = gameManager.getMoneyValue()
    }
    
    @IBAction func buy500FoodAction(_ sender: Any) {
        gameManager.buyFood(amount: 500)
        setUI()
    }
    
    @IBAction func closeWindow(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
