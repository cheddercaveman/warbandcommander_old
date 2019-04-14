//
//  GameTabBarViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 30.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
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
        
        let viewReference = UIBarButtonItem(title: "Reference", style: .plain, target: self, action: #selector(viewReferenceTapped))
        
        navigationItem.rightBarButtonItems = [viewReference]
    }
    
    @objc func viewReferenceTapped() {
        performSegue(withIdentifier: "showPdfSegue", sender: self)
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPdfSegue" {
            let pdfViewController = segue.destination as! PDFReaderViewController
            pdfViewController.pdfName = "Judgement_Rules_Reference_V1.4"
            pdfViewController.scrolling = false
            pdfViewController.title = "Rules Reference"
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let alert = UIAlertController(title: "Reset Game State", message: "What to reset?", preferredStyle: .alert)
            let resetAction = UIAlertAction(title: "Just reset", style: .destructive)  { (alert: UIAlertAction!) -> Void in
                GameState.sharedInstance.resetCurrentGame()
                PersistanceService.sharedInstance.persistGameState()
                self.reloadSubviewData()
            }
            let keepMineAction = UIAlertAction(title: "Delete all but mine", style: .destructive)  { (alert: UIAlertAction!) -> Void in
                GameState.sharedInstance.deleteCurrentGameButOwnWarband()
                PersistanceService.sharedInstance.persistGameState()
                self.reloadSubviewData()
            }
            let deleteAction = UIAlertAction(title: "Delete everything", style: .destructive)  { (alert: UIAlertAction!) -> Void in
                GameState.sharedInstance.deleteCurrentGame()
                PersistanceService.sharedInstance.persistGameState()
                self.reloadSubviewData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(resetAction)
            alert.addAction(keepMineAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion:nil)
        }
    }
    
    func reloadSubviewData() {
        if let vcs = self.viewControllers {
            for vc in vcs {
                (vc as? UICollectionViewController)?.collectionView?.reloadData()
            }
        }
    }
}
