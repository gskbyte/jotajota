//
//  Bar.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

class Bar: SKSpriteNode {
    var movable = false
    var rotable = false

    init(width: CGFloat) {
        super.init(texture: nil, color: .red, size: CGSize(width: width, height: 10))
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false

        self.physicsBody?.categoryBitMask = BarCategory
        self.physicsBody?.contactTestBitMask = BallCategory
        self.physicsBody?.collisionBitMask = BallCategory
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
