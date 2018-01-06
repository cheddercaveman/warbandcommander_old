//
//  GameGlobalsCollectionViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 29.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class GameGlobalsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, IngameMonsterCollectionViewCellDelegate, CardListCollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "monsterDetailSegue" {
            let destinationController = segue.destination as! CardDetailsViewController
            let button = sender as! UIButton
            let card = GameState.sharedInstance.monster[button.tag]
            destinationController.setCard(aCard: card.monster)
        }
        
        if segue.identifier == "monsterSelectionSegue" {
            let destinationController = segue.destination as! CardListViewController
            destinationController.delegate = self
            destinationController.viewType = .monsterSelection(headline: "Select Monster", cardCellIdentifier: "monsterCell", cardCellType: MonsterCollectionViewCell.self)
            
            destinationController.cardData = DatabaseService.sharedInstance.Monsters
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameState.sharedInstance.monster.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monsterCell", for: indexPath) as! IngameMonsterCollectionViewCell
            
            cell.initializeCell(withMonster: GameState.sharedInstance.monster[indexPath.item])
            cell.indexPath = indexPath.item
            cell.delegate = self
            
            return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
    
    func detailsButtonTouched(sender aSender: IngameMonsterCollectionViewCell) {
    }
    
    func deleteButtonTouched(sender aSender: IngameMonsterCollectionViewCell) {
        let alert = UIAlertController(title: "Remove Monster", message: "Are you sure you want to remove \(aSender.state?.monster!.name ?? "this monster")?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Remove", style: .destructive) { (alert: UIAlertAction!) -> Void in
            GameState.sharedInstance.monster.remove(at: aSender.tag)
            PersistanceService.sharedInstance.persistGameState()
            self.collectionView!.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    func damageIncreased(sender aSender: IngameMonsterCollectionViewCell) {
        GameState.sharedInstance.monster[aSender.indexPath].increaseDamage()
        aSender.updateCell()
        PersistanceService.sharedInstance.persistGameState()
    }
    
    func damageDecreased(sender aSender: IngameMonsterCollectionViewCell) {
        GameState.sharedInstance.monster[aSender.indexPath].decreaseDamage()
        aSender.updateCell()
        PersistanceService.sharedInstance.persistGameState()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 30)
    }
    
    func addToListButtonTouched(sender: UIButton, forCard card: CardBase?, withType viewType: CardListType) {
        switch viewType {
        case .monsterSelection(headline: _, cardCellIdentifier: _, cardCellType: _):
            GameState.sharedInstance.addMonster(monster: card as! MonsterModel)
        default:
            break
        }
        
        PersistanceService.sharedInstance.persistGameState()
        self.collectionView?.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! GenericCollectionHeaderView
        supplementaryCell.setTitle(aTitle: "Monster")
        
        return supplementaryCell
    }
    
    
    func addButtonTouched(sender: GenericCollectionHeaderView) {
        
    }
}

