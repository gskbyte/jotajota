//
//  Goal.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

class Goal: SKSpriteNode {
    init() {
        let radius : CGFloat = 32

        let texture = SKTexture(imageNamed:"goal")
        super.init(texture: texture, color: nil, size: CGSizeMake(radius*2, radius*2))
        self.name = "goal"
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GoalCategory
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
