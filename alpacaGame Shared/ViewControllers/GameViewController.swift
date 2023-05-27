//
//  GameViewController.swift
//  alpacaGame iOS
//
//  Created by Charlie Oxendine on 5/12/23.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var moneyTextField: UILabel!
    @IBOutlet weak var foodTextField: UILabel!
    @IBOutlet weak var alpacaCountLabel: UILabel!
    @IBOutlet weak var residenceCountLabel: UILabel!
    var gameController: GameController!
    let gameManager = GameManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: sceneView)
        
        // Allow the user to manipulate the camera
        self.sceneView.allowsCameraControl = true
        self.sceneView.cameraControlConfiguration.truckSensitivity = 0
        self.sceneView.cameraControlConfiguration.rotationSensitivity = 0
        
        //TODO: Make this toggle based on prod/debug
        self.sceneView.showsStatistics = false
        self.sceneView.backgroundColor = UIColor.black
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        var gestureRecognizers = sceneView.gestureRecognizers ?? []
        gestureRecognizers.insert(tapGesture, at: 0)
        self.sceneView.gestureRecognizers = gestureRecognizers
        
        setUI()
        gameManager.delegate = self
        gameManager.startTimers()
    }
    
    //Doing nothing in pan gesture other than  printing
    @objc func panDetected (sender: UIPanGestureRecognizer) {
        print("two pan detected")
    }
    
    func setUI() {
        headerView.layer.cornerRadius = 25
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    @objc
    func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        // Highlight the tapped nodes
        let p = gestureRecognizer.location(in: sceneView)
        gameController.highlightNodes(atPoint: p)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func foodButtonTouched(_ sender: Any) {
        let myViewController = PurchaseMenuHostingViewController()
        myViewController.setView(purchaseType: .food)
        self.present(myViewController, animated: true, completion: nil)
    }
    
    @IBAction func managerMenuButtonTapped(_ sender: Any) {
        let myViewController = PurchaseMenuHostingViewController()
        myViewController.setView(purchaseType: .managers)
        self.present(myViewController, animated: true, completion: nil)
    }
    
    @IBAction func residenceTapped(_ sender: Any) {
        let myViewController = PurchaseMenuHostingViewController()
        myViewController.setView(purchaseType: .residential)
        self.present(myViewController, animated: true, completion: nil)
    }
}

extension GameViewController: GameManagerDelegate {
    func resetHeaderStats(moneyCount: Float, moneyValue: String, foodCount: Float, alpacaCount: Float, residenceCount: Float) {
        DispatchQueue.main.async {
            print("VALUE: \(moneyValue)")
            self.moneyTextField.text = moneyValue
            self.foodTextField.text = "🌽: \(foodCount)"
            self.alpacaCountLabel.text = "🦙: \(alpacaCount)"
            self.residenceCountLabel.text = "🏠: \(residenceCount)"
        }
    }
}
