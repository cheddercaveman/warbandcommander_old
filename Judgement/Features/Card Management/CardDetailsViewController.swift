//
//  CardDetailsViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 25.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private var card: CardBase?
    private var cardViewControllers: [UIViewController] = []
    
    func setCard(aCard: CardBase) {
        self.card = aCard
        self.title = self.card!.name
        self.dataSource = self
        
        self.cardViewControllers = initializeCardViewControllers(aCard: aCard)
        
        if self.cardViewControllers.count == 0 {
            return
        }
        
        if let viewController = self.cardViewControllers.first {
            setViewControllers([viewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func initializeCardViewControllers(aCard: CardBase) -> [UIViewController] {
        var returnViewControllers = [UIViewController]()
        
        for i in 1 ... aCard.cardAmount {
            let viewController = UIViewController()

            let imageFileName = String(format: "%@%u.jpg", aCard.cardBasename, i)
            let image = UIImage(named: imageFileName)

            let imageView = UIImageView()
            imageView.image = image
            imageView.bounds = self.view.bounds
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFit
            viewController.view = imageView

            returnViewControllers.append(viewController)
        }
        
        return returnViewControllers
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.cardViewControllers.index(of: viewController) else {
            return nil
        }
        
        let newIndex = viewControllerIndex + 1
        
        if newIndex >= self.cardViewControllers.count {
            return nil
        }
        
        return self.cardViewControllers[newIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.cardViewControllers.index(of: viewController) else {
            return nil
        }
        
        let newIndex = viewControllerIndex - 1
        
        if newIndex < 0 {
            return nil
        }
        
        return self.cardViewControllers[newIndex]

    }
}
