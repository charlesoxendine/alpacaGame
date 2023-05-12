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
    private var industrialManager: Bool = false
    
    // MARK: Constants
    private let alpacasPerSecond: Float = 1
    private let moneyPerAlpacaPerSecond: Float = 0.01
    private let processerRatePerSecond: Float  = 1
    private let alpacaFoodConsumptionRate: Float = 1
    private let foodCostPerFifty: Float = 3
    
    // MARK: Timer
    private var gameTimer: Timer?
    
    public func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    private func endTimer() {
        gameTimer?.invalidate()
    }
    
    @objc func runTimedCode() {
        if industrialManager == true {
            money += getMoneyRate()
        }
        
        // If alpaca food is at 0 we will not consume food but we can also not produce anymore alpacas
        if alpacaFood > 0 {
            alpacaFood -= getAlpacaConsumtionRate()
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
        return alpacaCount * moneyPerAlpacaPerSecond
    }
    
    private func getProcesserRate() -> Float{
        return processerRatePerSecond
    }
    
    private func getAlpacaConsumtionRate() -> Float {
        return alpacaFoodConsumptionRate
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
    
    public func buyFood(amount: Float) {
        let cost = amount/50 * foodCostPerFifty
        if money < cost {
            // TODO: Handle error: Can't buy stupid
            return
        }
        
        self.alpacaFood += amount
        self.money -= cost
    }
    
    public func handleProcessorTap() {
        money += getMoneyRate()
        updateDelegates()
    }
}
