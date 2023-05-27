//
//  GameManager.swift
//  alpacaCorp iOS
//
//  Created by Charlie Oxendine on 5/12/23.
//

import Foundation

protocol GameManagerDelegate {
    func resetHeaderStats(moneyCount: Float, moneyValue: String, foodCount: Float, alpacaCount: Float, residenceCount: Float)
}

class GameManager {
    
    public static let shared = GameManager()
    var delegate: GameManagerDelegate?
    
    private init() {}
    
    public var money: Float = 40
    private var alpacaCount: Float = 20
    private var residenceCount: Float = 20
    private var processorCount: Float = 0
    private var alpacaFood: Float = 0
    
    // MARK: Constants
    // Numbers that we can make quick on the fly changes to, in order to slightly change game mechanics to make
    // for a better experience for our users.
    private let alpacasPerSecond: Float = 1
    private let moneyPerAlpacaPerSecond: Float = 0.1
    private let processerRatePerSecond: Float  = 1
    public let foodCostPerItem: Float = 0.4
    public let costPerResidence: Float = 0.4
    
    // MARK: Managers
    private var processingManager: Manager?
    private var animalHusbandryManager: Manager?
    
    // MARK: Timer
    private var gameTimer: Timer?
    
    // MARK: Bonuses
    private var foodBonusRate: Float = 2.5
    
    public func startTimers() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    private func endTimer() {
        gameTimer?.invalidate()
    }
    
    @objc func runTimedCode() {
        if processingManager != nil {
            // TODO: Eventually gotta check for cool down here
            money += getMoneyRate()
        }
        
        // Only create more if food is enough
        if animalHusbandryManager != nil && residenceCount > (alpacaCount + getAlpacaSpawnRate()) {
            // TODO: Should be dynaminc by level
            alpacaCount += getAlpacaSpawnRate()
        }
        
        updateDelegates()
    }
    
    func updateDelegates() {
        let moneyValue = self.getMoneyValue()
        delegate?.resetHeaderStats(moneyCount: money, moneyValue: moneyValue, foodCount: alpacaFood, alpacaCount: alpacaCount, residenceCount: residenceCount)
    }
    
    // MARK: Get Rates
    private func getAlpacaSpawnRate() -> Float {
        return alpacasPerSecond
    }
    
    private func getMoneyRate() -> Float {
        // If there is food for the herd, add bonus
        var rate = moneyPerAlpacaPerSecond
        if self.alpacaFood > alpacaCount {
            rate *= foodBonusRate
        }
        
        return alpacaCount * rate
    }
    
    private func getProcesserRate() -> Float{
        return processerRatePerSecond
    }
    
    private func getAlpacaConsumtionRate() -> Float {
        let consumptionRate = alpacaCount * 0.5
        return consumptionRate.rounded()
    }
    
    // MARK: Getters
    public func getMoneyValue() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: money as NSNumber) ?? "$0.00"
    }
    
    public func getAlpacaCount() -> Float {
        return alpacaCount
    }
    
    // MARK: Make Purchases
    public func buyFood(amount: Float) async throws -> Bool? {
        let cost = amount * foodCostPerItem
        if money < cost {
            throw NSError(
        }
        
        self.alpacaFood += amount
        self.money -= cost
    }
    
    public func buyManager(managerType: ManagerType) {
        let newManager = Manager(managerType: managerType, level: 1)
        
        switch managerType {
        case .breeding:
            let cost = Float(1500)
            guard GameManager.shared.money >= cost else {
                return
            }
            
            self.money -= cost
            self.animalHusbandryManager = newManager
        case .processing:
            let cost = Float(2500)
            guard GameManager.shared.money >= cost else {
                return
            }
            
            self.money -= cost
            self.processingManager = newManager
        case .shipping:
            print("NOT FINISHED YET")
        }
    }
    
    public func buyResidence(alpacaSpace: Int) {
        let totalCost = (costPerResidence * Float(alpacaSpace))
        guard GameManager.shared.money > totalCost else {
            return
        }
        
        self.money -= totalCost
        self.residenceCount += Float(alpacaSpace)
        updateDelegates()
    }
    
    // MARK: Building Actions
    public func handleProcessorTap() {
        money += getMoneyRate()
        
        // The user has food, but not enough to feed the whole herd
        if alpacaFood <= getAlpacaConsumtionRate() {
            alpacaFood = 0
        } else {
            alpacaFood -= getAlpacaConsumtionRate()
        }
        
        updateDelegates()
    }
    
    public func handleHusbandryTap() {
        if residenceCount > self.alpacaCount {
            alpacaCount += getAlpacaSpawnRate()
        }
        
        updateDelegates()
    }
    
    // MARK: UTILITIES
    public static func getMoneyValue(value: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: value as NSNumber) ?? "$0.00"
    }
}
