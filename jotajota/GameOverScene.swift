//
//  GameOverScene.swift
//  jotajota
//
//  Created by Jorge Enrique Salgado Martin on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    init(size: CGSize, playerWon: Bool) {
        super.init(size:size)
        let gameOverLabel = SKLabelNode(fontNamed:"Arial");
        gameOverLabel.fontSize = 42;
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        if (playerWon) {
            gameOverLabel.text = "Game Won";
        } else {
            gameOverLabel.text = "Game Over";
        }
        self.addChild(gameOverLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let newScene = GameScene(size: self.size)
        self.view?.presentScene(newScene)
    }
}
