//
//  CardListViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit
import GRDB

protocol CardListCollectionViewDelegate {
    func addToListButtonTouched(sender: UIButton, forCard card: CardBase?, withType viewType: CardListType)
}

class CardListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    enum IndexPathSections : Int {
        case header = 0
        case cards = 1
    }
    
    private var headline: String?
    private var cardCellIdentifier: String?
    var cardData: [CardBase]?
    private var filteredCardData: [CardBase]?
    private var cardCellType: CardCollectionViewCell.Type?
    
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
                 .offensiveArtefactSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype, referenceId: _),
                 .defensiveArtefactSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype, referenceId: _),
                 .shrineSelection(headline: let headline, cardCellIdentifier: let identifier, cardCellType: let celltype):
                self.headline = headline
                self.cardCellIdentifier = identifier
                self.cardCellType = celltype
                self.enableCardSelection = true
            default:
                break
            }
        }
    }
    
    var enableCardSelection: Bool = false
    var delegate: CardListCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: self)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.headline!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch (section) {
        case IndexPathSections.header.rawValue:
            return 1
        case IndexPathSections.cards.rawValue:
            if self.isFiltering() {
                if let count = self.filteredCardData?.count {
                    return count
                }
            }
            if let count = self.cardData?.count {
                return count
            }
        default:
            return 0
        }
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch (indexPath.section) {
        case IndexPathSections.header.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath)
            return cell
            
        case IndexPathSections.cards.rawValue:
            if let card = self.cardData?[indexPath.item] {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cardCellIdentifier!, for: indexPath) as? CardCollectionViewCell {
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
        if section == 1 {
            return CGSize(width: self.view.bounds.width, height: 30)
        }
        
        return CGSize()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CardCollectionHeaderView
        if indexPath.section == 1 {
            supplementaryCell.setTitle(aTitle: self.headline!)
        }
        
        return supplementaryCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch (indexPath.section) {
        case IndexPathSections.header.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 120)
        case IndexPathSections.cards.rawValue:
            if self.enableCardSelection {
                return CGSize(width: collectionView.bounds.width, height: 80)
            }
            return CGSize(width: collectionView.bounds.width, height: 50)
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
    
    func searchBarIsEmpty() -> Bool {
        return self.navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return (self.navigationItem.searchController?.isActive)! && !searchBarIsEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        self.filteredCardData = self.cardData?.filter({( c : CardBase) -> Bool in
            return c.name.lowercased().contains(searchString.lowercased())
        })
        
        collectionView?.reloadData()
        
    }
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        self.delegate?.addToListButtonTouched(sender: sender, forCard: self.cardData?[sender.tag], withType: self.viewType)
    }
}

