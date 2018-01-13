//
//  AboutTableViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 28.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    
    var socialMediaIcons: Dictionary<Int, [String]> = Dictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Oliver
        self.socialMediaIcons[0] = [
            "",
            "mailto:judgement@nogoodname.net",
            "https://www.facebook.com/ohauth",
            "https://www.twitter.com/spielerview",
            ""
        ]
        
        // Judgement
        self.socialMediaIcons[1]  = [
            "https://judgement.game",
            "",
            "https://www.facebook.com/play.judgement",
            "https://twitter.com/PlayJudgement",
            ""
        ]
        
        // Headblast
        self.socialMediaIcons[2] = [
            "http://www.headblast.de",
            "",
            "https://www.facebook.com/HeadblastOberhausen/",
            "",
            "https://www.instagram.com/headblast.oberhausen/"
        ]
        
        // RPG Awesome
        self.socialMediaIcons[3] = [
            "https://nagoshiashumari.github.io/Rpg-Awesome/",
            "",
            "",
            "",
            ""
        ]
    }

    @IBAction func mailButtonTouched(_ sender: UIButton) {
        if let address = self.socialMediaIcons[sender.tag]?[SocialMediaEnum.email.rawValue] {
            if address != "" {
                UIApplication.shared.open(URL(string: address)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func webButtonTouched(_ sender: UIButton) {
        if let address = self.socialMediaIcons[sender.tag]?[SocialMediaEnum.website.rawValue] {
            if address != "" {
                UIApplication.shared.open(URL(string: address)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func facebookButtonTouched(_ sender: UIButton) {
        if let address = self.socialMediaIcons[sender.tag]?[SocialMediaEnum.facebook.rawValue] {
            if address != "" {
                UIApplication.shared.open(URL(string: address)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func twitterButtonTouched(_ sender: UIButton) {
        if let address = self.socialMediaIcons[sender.tag]?[SocialMediaEnum.twitter.rawValue] {
            if address != "" {
                UIApplication.shared.open(URL(string: address)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func instagramButtonTouched(_ sender: UIButton) {
        if let address = self.socialMediaIcons[sender.tag]?[SocialMediaEnum.instragram.rawValue] {
            if address != "" {
                UIApplication.shared.open(URL(string: address)!, options: [:], completionHandler: nil)
            }
        }
    }
}
