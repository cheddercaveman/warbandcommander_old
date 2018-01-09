//
//  CardListViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit
import GRDB

protocol CardListCollectionViewDelegate {
    func addToListButtonTouched(sender: UIButton, forCard card: CardBase?, withType viewType: CardListType)
    func dismissButtonTouched(sender: UIButton, withType viewType: CardListType)
}

class CardListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum IndexPathSections : Int {
        case header = 0
        case cancelArtefact = 1
        case cards = 2
    }
    
    private var headline: String?
    private var cardCellIdentifier: String?
    var cardData: [CardBase]?
    private var filteredCardData: [CardBase]?
    private var cardCellType: BaseCardCell.Type?
    private var dismissEnabled: Bool = false
    
    private var _viewType: CardListType = .undefined
    var viewType: CardListType {
        get { return self._viewType }
        set {
            self._viewType = newValue
            switch (self._viewType) {
            case .characterPreview(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype),
                 .monsterPreview(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype),
                 .artefactPreview(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype),
                 .shrinePreview(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype):
                self.headline = headline
                self.cardCellIdentifier = identifier
                self.cardCellType = celltype
                self.enableCardSelection = false
            case .characterSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype),
                 .monsterSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype),
                 .shrineSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype):
                self.headline = headline
                self.cardCellIdentifier = identifier
                self.cardCellType = celltype
                self.enableCardSelection = true
            case .offensiveArtefactSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype, enableDismiss: let dismissEnabled, referenceId: _),
                 .defensiveArtefactSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype, enableDismiss: let dismissEnabled, referenceId: _):
                self.headline = headline
                self.cardCellIdentifier = identifier
                self.cardCellType = celltype
                self.enableCardSelection = true
                self.dismissEnabled = dismissEnabled
            default:
                break
            }
        }
    }
    
    var enableCardSelection: Bool = false
    var delegate: CardListCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.headline!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch (section) {
        case IndexPathSections.header.rawValue:
            return 1
        case IndexPathSections.cancelArtefact.rawValue:
            return self.dismissEnabled ? 1 : 0
        case IndexPathSections.cards.rawValue:
            return self.cardData?.count ?? 0
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch (indexPath.section) {
        case IndexPathSections.header.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath)
            return cell
        case IndexPathSections.cancelArtefact.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dismissCell", for: indexPath)
            return cell
            
        case IndexPathSections.cards.rawValue:
            if let card = self.cardData?[indexPath.item] {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cardCellIdentifier!, for: indexPath) as? BaseCardCell {
                    cell.setCard(aCard: card, forindex: indexPath.item)
                    return cell
                }
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return (section == IndexPathSections.cards.rawValue) ? CGSize(width: self.view.bounds.width, height: 30) : CGSize.zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == IndexPathSections.cards.rawValue {
            let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CardCollectionHeaderView
            supplementaryCell.setTitle(aTitle: self.headline!)
            return supplementaryCell
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch (indexPath.section) {
        case IndexPathSections.header.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 120)
        case IndexPathSections.cancelArtefact.rawValue:
            return self.dismissEnabled ? CGSize(width: collectionView.bounds.width, height: 50) : CGSize.zero
        case IndexPathSections.cards.rawValue:
            return self.enableCardSelection ? CGSize(width: collectionView.bounds.width, height: 80) : CGSize(width: collectionView.bounds.width, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetailSegue"
            || segue.identifier == "monsterDetailSegue"
            || segue.identifier == "shrineDetailSegue"
            || segue.identifier == "artefactDetailSegue" {
            
            let destinationController = segue.destination as! CardDetailsViewController
            let button = sender as! UIButton
            
            if let card = self.cardData?[button.tag] {
                destinationController.setCard(aCard: card)
            }
        }
    }
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        self.delegate?.addToListButtonTouched(sender: sender, forCard: self.cardData?[sender.tag], withType: self.viewType)
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.delegate?.dismissButtonTouched(sender: sender, withType: self.viewType)
    }
}

