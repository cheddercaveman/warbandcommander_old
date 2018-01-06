//
//  PersistanceService.swift
//  Judgement
//
//  Created by Oliver Hauth on 04.01.18.
//  Copyright © 2018 Headblast Oberhausen e.V. All rights reserved.
//

import Foundation

class PersistanceService {
    static let sharedInstance: PersistanceService = PersistanceService()
    
    var StateFileURL: URL? = nil
    
    init() {
        if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            self.StateFileURL = URL(fileURLWithPath: documentsPath).appendingPathComponent("gamestate.json")
        }
    }
    
    func persistGameState() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(GameState.sharedInstance)
            try data.write(to: self.StateFileURL!)
        }
        catch {
            
        }
    }
    
    func retrieveGameState() {
        let decoder = JSONDecoder()
        do {
            let data: Data = try Data(contentsOf: self.StateFileURL!, options: .uncached)
            let newGameState = try decoder.decode(GameState.self, from: data)

            GameState.sharedInstance.ownWarband = newGameState.ownWarband
            GameState.sharedInstance.enemyWarband = newGameState.enemyWarband
            GameState.sharedInstance.monster = newGameState.monster
        }
        catch {
            
        }
    }
}


