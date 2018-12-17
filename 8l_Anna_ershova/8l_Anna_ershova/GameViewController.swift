//
//  GameViewController.swift
//  8l_Anna_ershova
//
//  Created by Anna Ershova on 17/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: self.view.bounds.size)
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }
}
