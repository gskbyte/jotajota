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

    init(width : CGFloat) {
        super.init(texture: nil, color: UIColor.redColor(), size: CGSizeMake(width, 10))
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody?.dynamic = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
