//
//  MainMenuCollectionViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 26.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class MainMenuCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var mainMenuCollectionView: UICollectionView!
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    let menuTitles: [String] = [
        "Characters",
        "Monsters",
        "Artefacts",
        "Shrines",
        "Rulebook",
        "About"
    ]
    
    let menuIcons: [String?] = [
        "",
        "",
        "",
        "",
        "",
        ""
    ]
    
    let segues: [String] = [
        "cardListSegue",
        "cardListSegue",
        "cardListSegue",
        "cardListSegue",
        "manualSegue",
        "aboutSegue"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        if indexPath.section == 1 {
            switch (indexPath.item) {
            case 0:
                let cardListController = segue.destination as! CardListViewController
                cardListController.viewType = .characterPreview(headline: "Character", cardCellIdentifier: "characterCell", cardCellType: CharacterCardCell.self)
                cardListController.cardData = DatabaseService.sharedInstance.Characters
            case 1:
                let cardListController = segue.destination as! CardListViewController
                cardListController.viewType = .monsterPreview(headline: "Monster", cardCellIdentifier: "monsterCell", cardCellType: MonsterCardCell.self)
                cardListController.cardData = DatabaseService.sharedInstance.Monsters
            case 2:
                let cardListController = segue.destination as! CardListViewController
                cardListController.viewType = .artefactPreview(headline: "Artefacts", cardCellIdentifier: "artefactCell", cardCellType: ArtefactCardCell.self)
                cardListController.cardData = DatabaseService.sharedInstance.Artefacts
            case 3:
                let cardListController = segue.destination as! CardListViewController
                cardListController.viewType = .shrinePreview(headline: "Shrines", cardCellIdentifier: "shrineCell", cardCellType: ShrineCardCell.self)
                cardListController.cardData = DatabaseService.sharedInstance.Shrines
            case 4:
                let pdfViewController = segue.destination as! PDFReaderViewController
                pdfViewController.pdfName = "Judgement_RuleBook_V1.1"
            default:
                break
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.menuTitles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuCurrentGame", for: indexPath) as! MainMenuCollectionViewCell
            
            cell.titleLabel!.text = "Current Game"
            cell.iconLabel!.text = ""
            cell.layer.borderWidth = 1.0;
            cell.layer.borderColor = UIColor.white.cgColor
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuEntry", for: indexPath) as! MainMenuCollectionViewCell
            
            cell.titleLabel!.text = self.menuTitles[indexPath.item]
            cell.iconLabel!.text = self.menuIcons[indexPath.item]
            cell.layer.borderWidth = 1.0;
            cell.layer.borderColor = UIColor.white.cgColor
            return cell
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch (kind) {
        case UICollectionElementKindSectionHeader:
            let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainMenuHeader", for: indexPath)
            
            return supplementaryCell
        case UICollectionElementKindSectionFooter:
            let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainMenuFooter", for: indexPath)
            
            return supplementaryCell
        default:
            return UICollectionReusableView()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 0:
            performSegue(withIdentifier: "currentGameSegue", sender: indexPath)
        case 1:
            if self.segues[indexPath.item] != "" {
                performSegue(withIdentifier: self.segues[indexPath.item], sender: indexPath)
            }
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0) {
            return CGSize(width: collectionView.bounds.width, height: 80)
        }
        
        return CGSize(width: (collectionView.bounds.width - 2) / 3, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: self.view.bounds.width, height: 200) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == 0 ? CGSize.zero : CGSize(width: self.view.bounds.width, height: 50)
    }
}

