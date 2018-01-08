//
//  GameTabBarViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 30.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class GameStateTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersistanceService.sharedInstance.retrieveGameState()

        self.title = "Current Game"

        guard let ownWarbandView = storyboard?.instantiateViewController(withIdentifier: "warbandView") as? WarbandCollectionViewController else {
            return
        }
        ownWarbandView.title = "Your Warband"
        ownWarbandView.tabBarItem.image = #imageLiteral(resourceName: "ownWarband")
        ownWarbandView.warband = GameState.sharedInstance.ownWarband
        
        guard let enemyWarbandView = storyboard?.instantiateViewController(withIdentifier: "warbandView") as? WarbandCollectionViewController else {
            return
        }
        enemyWarbandView.title = "Enemy Warband"
        enemyWarbandView.tabBarItem.image = #imageLiteral(resourceName: "enemyWarband")
        enemyWarbandView.warband = GameState.sharedInstance.enemyWarband

        guard let globalView = storyboard?.instantiateViewController(withIdentifier: "globalView") as? GameGlobalsCollectionViewController else {
            return
        }
        globalView.title = "Monster"
        globalView.tabBarItem.image = #imageLiteral(resourceName: "gameGlobals")

        self.viewControllers = [ownWarbandView, enemyWarbandView, globalView]
    }
}
