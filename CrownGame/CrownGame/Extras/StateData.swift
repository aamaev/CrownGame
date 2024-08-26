//
//  StateData.swift
//  CrownGame
//
//

import Foundation
import AVFoundation

class StateData: ObservableObject {
    @Published var bet: Int = 0
    @Published var background: String = "menu_background"
    @Published var currentBank: Int = 0
    @Published var balance: Int {
        didSet {
            UserDefaults.standard.set(balance, forKey: "balance")
        }
    }

    init() {
        self.balance = 1500
        
        let storedBalance = UserDefaults.standard.integer(forKey: "balance")
        if storedBalance != 0 {
            self.balance = storedBalance
        }
    }
    
    func changeBalance(by amount: Int) {
        balance += amount
    }
    
    func changeBackground(bg: String) {
        background = bg
    }

}


