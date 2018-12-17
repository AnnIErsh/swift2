//
//  SnakeHead.swift
//  8l_Anna_ershova
//
//  Created by Anna Ershova on 17/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
