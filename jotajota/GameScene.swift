//
//  GameScene.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    var ball : Ball!
    var goal : Goal!
    var interruptors = Array<Interruptor>()
    var motionManager : CMMotionManager!
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
        motionManager = CMMotionManager()
        motionManager!.startAccelerometerUpdates()
    }

    func setupWorld() {
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    }

    func setupBall() {
        ball = Ball()
        ball.position = CGPointMake(300, frame.size.height)
        self.addChild(ball)
    }

    func setupGoal () {
        goal = Goal()
        goal.position = CGPointMake(size.width / 2 + 1, 200)
        self.addChild(goal)
    }

    func setupBars() {
        var bar = Bar(width: 200)
        bar.position = CGPointMake(300, 500)
        bar.zRotation = 0.3;
        self.addChild(bar)

        bar = Bar(width: 200)
        bar.position = CGPointMake(60, 480)
        bar.zRotation = -0.2;
        self.addChild(bar)

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
            
//            ball.physicsBody?.applyForce(CGVectorMake(0, -9.8))
//            println("La velocidad es: \(ball.physicsBody?.velocity.dy)")
//            ball.physicsBody?.velocity = CGVectorMake(0, -9.8)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.processUserMotionForUpdate(currentTime)
    }
    
    func processUserMotionForUpdate(currentTime: NSTimeInterval) {
        if let motionData = motionManager!.accelerometerData {
        let acceleration = motionData.acceleration
            if (fabs(acceleration.x) > 0.2 || fabs(acceleration.y) > 0.2) {
                let currentGravity = self.physicsWorld.gravity                
                let finalGravity = CGVectorMake(currentGravity.dx + CGFloat(acceleration.x)*20, currentGravity.dy + CGFloat(acceleration.y)*20)
                physicsWorld.gravity = self.normalizeVector(finalGravity)
            }
        }
    }
    
    func normalizeVector(vector:CGVector) -> CGVector {
    let length = hypotf(Float(vector.dx), Float(vector.dy));
    
    if length == 0 {
        return CGVectorMake(0, 0);
    }
    
    let scale = 9.8 / length;
    return CGVectorMake(vector.dx * CGFloat(scale), vector.dy * CGFloat(scale));
    }
    
}
