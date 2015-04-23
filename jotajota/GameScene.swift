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
    var goal : Goal!
    var interruptors = Array<Interruptor>()
    var bars = Array<Bar>()
    var spikes = Array<Spike>()

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        setupWorld()
        setupGoal()
        setupBall()
        setupBars()
        setupInterruptors()
        setupSpikes()
    }

    func setupWorld() {
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    }

    func setupBall() {
        ball = Ball()
        ball.position = CGPointMake(frame.size.width / 2, frame.size.height - 30)
        self.addChild(ball)
    }

    func setupGoal () {
        goal = Goal()
        goal.position = CGPointMake(size.width / 2 + 1, 200)
        self.addChild(goal)
    }

    func setupBars() {
        let bar0 = Bar(width: 200)
        bar0.position = CGPointMake(self.size.width / 2, 100)
        self.addChild(bar0)
    }

    func setupInterruptors() {
        let interruptor = Interruptor()
        interruptor.position = CGPointMake(20, 20)
        self.addChild(interruptor)
    }

    func setupSpikes() {
        let spike = Spike()
        spike.position = CGPointMake(80, 20)
        self.addChild(spike)
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
