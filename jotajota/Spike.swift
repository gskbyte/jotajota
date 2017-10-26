//
//  Spike.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

class Spike: SKSpriteNode {
    init() {
        let radius : CGFloat = 20

        let texture = SKTexture(imageNamed:"spike")
        super.init(texture: texture, color: .clear, size: CGSize(width: radius*2, height: radius*2))
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)

        self.physicsBody?.isDynamic = false
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 0.4

        self.physicsBody?.categoryBitMask = SpikeCategory
        self.physicsBody?.contactTestBitMask = CollidableCategory
        self.physicsBody?.collisionBitMask = CollidableCategory
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
