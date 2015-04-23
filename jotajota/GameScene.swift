//
//  GameScene.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var ball : Ball!
    var bars = Array<Bar>()

    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        

        ball = Ball()
        ball.position = CGPointMake(frame.size.width / 2, frame.size.height - 30)
        self.addChild(ball)

        let bar0 = Bar(width: 40)
        bar0.position = CGPointMake(self.size.width / 2, 100)
        self.addChild(bar0)


    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
