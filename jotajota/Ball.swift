//
//  Ball.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

class Ball: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed:"ball")
        super.init(texture: texture, color: nil, size: CGSizeMake(24, 24))
        self.name = "ball"

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
