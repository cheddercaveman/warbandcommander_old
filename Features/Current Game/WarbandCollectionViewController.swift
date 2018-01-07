//
//  WarbandCollectionViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 29.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class WarbandCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, IngameCharacterCollectionViewCellDelegate, CardListCollectionViewDelegate {
    var warband: WarbandState?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetailSegue" {
            let destinationController = segue.destination as! CardDetailsViewController
            let button = sender as! UIButton
            if let card = self.warband?.characters[button.tag] {
                destinationController.setCard(aCard: card.character!)
            }
        }
        
        if segue.identifier == "characterSelectionSegue" {
            let destinationController = segue.destination as! CardListViewController
            destinationController.delegate = self
            destinationController.viewType = .characterSelection(headline: "Select Character", cardCellIdentifier: "characterCell", cardCellType: CharacterCollectionViewCell.self)
            
            destinationController.cardData = DatabaseService.sharedInstance.Characters?.filter({ (c) -> Bool in
                return !(self.warband?.containsCharacter(aCharacter: c) ?? false)
            })
        }
        
        if segue.identifier == "offensiveArtefactSelectionSegue" {
            let destinationController = segue.destination as! CardListViewController
            let senderButton = sender as! UIButton

            destinationController.delegate = self
            destinationController.viewType = .offensiveArtefactSelection(headline: "Select Artefact", cardCellIdentifier: "artefactCell", cardCellType: ArtefactCollectionViewCell.self, enableDismiss: (self.warband!.characters[senderButton.tag].offensiveArtefact != nil), referenceId: senderButton.tag)

            destinationController.cardData = DatabaseService.sharedInstance.Artefacts?.filter({ (a) -> Bool in
                return a.trait == .offense
            })
            
        }

        if segue.identifier == "defensiveArtefactSelectionSegue" {
            let destinationController = segue.destination as! CardListViewController
            let senderButton = sender as! UIButton

            destinationController.delegate = self
            destinationController.viewType = .defensiveArtefactSelection(headline: "Select Artefact", cardCellIdentifier: "artefactCell", cardCellType: ArtefactCollectionViewCell.self, enableDismiss: (self.warband!.characters[senderButton.tag].defensiveArtefact != nil), referenceId: senderButton.tag)
            
            destinationController.cardData = DatabaseService.sharedInstance.Artefacts?.filter({ (a) -> Bool in
                return a.trait == .defense
            })
            
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0 // Warband Globals
        
        default:
            return self.warband?.characters.count ?? 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "warbandGlobalCell", for: indexPath)
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! IngameCharacterCollectionViewCell
            
            cell.initializeCell(withCharacter: self.warband!.characters[indexPath.item])
            cell.indexPath = indexPath.item
            cell.delegate = self
            
            return cell
        }
    }

    func deleteButtonTouched(sender aSender: IngameCharacterCollectionViewCell) {
        let alert = UIAlertController(title: "Remove Character", message: "Are you sure you want to remove \(aSender.state!.character!.name)?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Remove", style: .destructive) { (alert: UIAlertAction!) -> Void in
            self.warband?.characters.remove(at: aSender.tag)
            PersistanceService.sharedInstance.persistGameState()
            self.collectionView!.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    func damageIncreased(sender aSender: IngameCharacterCollectionViewCell) {
        let character = self.warband?.characters.first { (c) -> Bool in
            return c.character!.id == aSender.state!.character!.id
        }
        
        character?.increaseDamage()
        aSender.updateCell()
        PersistanceService.sharedInstance.persistGameState()
    }
    
    func damageDecreased(sender aSender: IngameCharacterCollectionViewCell) {
        let character = self.warband?.characters.first { (c) -> Bool in
            return c.character!.id == aSender.state!.character!.id
        }
        
        character?.decreaseDamage()
        aSender.updateCell()
        PersistanceService.sharedInstance.persistGameState()
    }
    
    func levelIncreased(sender aSender: IngameCharacterCollectionViewCell) {
        let character = self.warband?.characters.first { (c) -> Bool in
            return c.character!.id == aSender.state!.character!.id
        }
        
        character?.increaseLevel()
        aSender.updateCell()
        PersistanceService.sharedInstance.persistGameState()
    }
    
    func levelDecreased(sender aSender: IngameCharacterCollectionViewCell) {
        let character = self.warband?.characters.first { (c) -> Bool in
            return c.character!.id == aSender.state!.character!.id
        }
        
        character?.decreaseLevel()
        aSender.updateCell()
        PersistanceService.sharedInstance.persistGameState()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch (indexPath.section) {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 130)
        default:
            return CGSize(width: collectionView.bounds.width, height: 410)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize.zero
        default:
            return CGSize(width: self.view.bounds.width, height: 30)
        }
    }
    
    func addToListButtonTouched(sender: UIButton, forCard card: CardBase?, withType viewType: CardListType) {
        switch viewType {
        case .characterSelection(headline: _, cardCellIdentifier: _, cardCellType: _):
            self.warband?.addCharacter(aCharacter: card as! CharacterModel)
        case .offensiveArtefactSelection(headline: _, cardCellIdentifier: _, cardCellType: _, enableDismiss: _,  referenceId: let index):
            self.warband?.characters[index].assignOffensiveArtefact(anArtefact: card as! ArtefactModel)
        case .defensiveArtefactSelection(headline: _, cardCellIdentifier: _, cardCellType: _, enableDismiss: _, referenceId: let index):
            self.warband?.characters[index].assignDefensiveArtefact(anArtefact: card as! ArtefactModel)
        default:
            break
        }
        
        PersistanceService.sharedInstance.persistGameState()
        self.collectionView?.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismissButtonTouched(sender: UIButton, withType viewType: CardListType) {
        switch viewType {
        case .offensiveArtefactSelection(headline: _, cardCellIdentifier: _, cardCellType: _, enableDismiss: _, referenceId: let index):
            self.warband?.characters[index].removeOffensiveArtefact()
        case .defensiveArtefactSelection(headline: _, cardCellIdentifier: _, cardCellType: _, enableDismiss: _, referenceId: let index):
            self.warband?.characters[index].removeDefensiveArtefact()
        default:
            break
        }
        
        PersistanceService.sharedInstance.persistGameState()
        self.collectionView?.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! GenericCollectionHeaderView
        if indexPath.section == 1 {
            supplementaryCell.setTitle(aTitle: "Characters")
        }
        
        return supplementaryCell
    }
}
