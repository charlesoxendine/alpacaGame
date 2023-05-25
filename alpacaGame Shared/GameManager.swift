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
    
    private var money: Float = 40
    private var alpacaCount: Float = 0
    private var residenceCount: Float = 0
    private var processorCount: Float = 0
    private var alpacaFood: Float = 0
    
    // MARK: Constants
    // Numbers that we can make quick on the fly changes to, in order to slightly change game mechanics to make
    // for a better experience for our users.
    private let alpacasPerSecond: Float = 1
    private let moneyPerAlpacaPerSecond: Float = 0.05
    private let processerRatePerSecond: Float  = 1
    private let foodCostPerFifty: Float = 3
    
    // MARK: Managers
    private var processingManager: Manager?
    private var animalHusbandryManager: Manager?
    
    // MARK: Timer
    private var gameTimer: Timer?
    
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
        
        // The user has food, but not enough to feed the whole herd
        if alpacaFood <= getAlpacaConsumtionRate() {
            alpacaFood = 0
        } else {
            alpacaFood -= getAlpacaConsumtionRate()
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
        let rate = moneyPerAlpacaPerSecond * alpacaFood
        return alpacaCount * moneyPerAlpacaPerSecond
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
    public func buyFood(amount: Float) {
        let cost = amount/50 * foodCostPerFifty
        if money < cost {
            // TODO: Handle error: Can't buy stupid
            return
        }
        
        self.alpacaFood += amount
        self.money -= cost
    }
    
    public func buyManager(managerType: ManagerType) {
        let newManager = Manager(managerType: managerType)
        
        switch managerType {
        case .animalHusbandry:
            self.animalHusbandryManager = newManager
        case .processing:
            self.processingManager = newManager
        }
    }
    
    public func buyResidence(alpacaSpace: Int) {
        self.residenceCount += Float(alpacaSpace)
    }
    
    // MARK: Building Actions
    public func handleProcessorTap() {
        money += getMoneyRate()
        updateDelegates()
    }
    
    public func handleHusbandryTap() {
        if residenceCount > self.alpacaCount {
            alpacaCount += getAlpacaSpawnRate()
        }
    }
}
