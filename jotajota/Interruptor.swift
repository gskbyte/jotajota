//
//  Interruptor.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

class Interruptor: SKSpriteNode {
    weak var spike : Spike?

    init() {
        let size = CGSize(width: 30, height: 30)

        super.init(texture: nil, color: .green, size: size)
        self.name = "interruptor"
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = InterruptorCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BallCategory
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
