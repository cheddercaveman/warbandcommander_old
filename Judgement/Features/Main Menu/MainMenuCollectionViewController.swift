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
        "Heroes",
        "Monsters",
        "Artefacts",
        "Shrines",
        "Rulebook",
        "Gods"
    ]
    
    let menuIcons: [String?] = [
        "",
        "",
        "",
        "",
        "",
        ""
    ]
    
    let segues: [String] = [
        "cardListSegue",
        "cardListSegue",
        "cardListSegue",
        "cardListSegue",
        "manualSegue",
        "manualSegue"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath, indexPath.section == 1 else { return }

        switch indexPath.item {
        case 0:
            guard let cardListController = segue.destination as? CardListViewController else { return }
            cardListController.viewType = .characterPreview(headline: "Heroes", cardCellIdentifier: "characterCell", cardCellType: CharacterCardCell.self)
            cardListController.cardData = DatabaseService.sharedInstance.Characters
        case 1:
            guard let cardListController = segue.destination as? CardListViewController else { return }
            cardListController.viewType = .monsterPreview(headline: "Monsters", cardCellIdentifier: "monsterCell", cardCellType: MonsterCardCell.self)
            cardListController.cardData = DatabaseService.sharedInstance.Monsters
        case 2:
            guard let cardListController = segue.destination as? CardListViewController else { return }
            cardListController.viewType = .artefactPreview(headline: "Artefacts", cardCellIdentifier: "artefactCell", cardCellType: ArtefactCardCell.self)
            cardListController.cardData = DatabaseService.sharedInstance.Artefacts
        case 3:
            guard let cardListController = segue.destination as? CardListViewController else { return }
            cardListController.viewType = .shrinePreview(headline: "Shrines", cardCellIdentifier: "shrineCell", cardCellType: ShrineCardCell.self)
            cardListController.cardData = DatabaseService.sharedInstance.Shrines
        case 4:
            guard let pdfViewController = segue.destination as? PDFReaderViewController else { return }
            pdfViewController.pdfName = "Judgement_Rulebook_Version_2"
            pdfViewController.scrollPositionKey = .rulebookScrollPosition
            pdfViewController.title = "Rulebook"
        case 5:
            guard let pdfViewController = segue.destination as? PDFReaderViewController else { return }
            pdfViewController.pdfName = "Judgement_Gods_OpenBeta_v1.0.0"
            pdfViewController.scrollPositionKey = .tournamentPackScrollPosition
            pdfViewController.title = "Gods"
        default:
            break
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? self.menuTitles.count : 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuCurrentGame", for: indexPath) as! MainMenuCollectionViewCell
            
            cell.titleLabel!.text = "Current Game"
            cell.iconLabel!.text = ""
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.white.cgColor
            return cell
        }
        else if (indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuEntry", for: indexPath) as! MainMenuCollectionViewCell
            
            cell.titleLabel!.text = self.menuTitles[indexPath.item]
            cell.iconLabel!.text = self.menuIcons[indexPath.item]
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.white.cgColor
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuCurrentGame", for: indexPath) as! MainMenuCollectionViewCell
            
            cell.titleLabel!.text = "About"
            cell.iconLabel!.text = ""
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.white.cgColor
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainMenuHeader", for: indexPath)
            return supplementaryCell
        case UICollectionView.elementKindSectionFooter:
            let supplementaryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainMenuFooter", for: indexPath)
            return supplementaryCell
        default:
            return UICollectionReusableView()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "currentGameSegue", sender: indexPath)
        case 1:
            if self.segues[indexPath.item] != "" {
                performSegue(withIdentifier: self.segues[indexPath.item], sender: indexPath)
            }
        case 2:
            performSegue(withIdentifier: "aboutSegue", sender: indexPath)
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section != 1 {
            return CGSize(width: collectionView.bounds.width, height: 80)
        }
        
        return CGSize(width: (collectionView.bounds.width - 2) / 3, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: self.view.bounds.width, height: 200) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section != 2 ? CGSize.zero : CGSize(width: self.view.bounds.width, height: 50)
    }
}

