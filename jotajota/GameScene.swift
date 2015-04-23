//
//  GameScene.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
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

        setupPhase0()
        setupPhase1()
        setupPhase2()
        setupPhase3()

        motionManager = CMMotionManager()
        motionManager!.startAccelerometerUpdates()
    }

    func setupWorld() {
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.contactDelegate = self;
    }

    func setupBall() {
        ball = Ball()
        ball.position = CGPointMake(320, frame.size.height)
        self.addChild(ball)
    }

    func setupGoal () {
        goal = Goal()
        goal.position = CGPointMake(30, 340)
        self.addChild(goal)
    }

    func setupPhase0() {
        var bar = makeBar(200)
        bar.position = CGPointMake(320, 500)
        bar.zRotation = 0.3

        bar = makeBar(200)
        bar.position = CGPointMake(60, 470)
        bar.zRotation = -0.2;

        var spike = makeSpike()
        spike.position = CGPointMake(190, 450)

        var interruptor = makeInterruptor()
        interruptor.position = CGPointMake(60, 520)
        interruptor.spike = spike

        spike = makeSpike()
        spike.position = CGPointMake(20, 520)
    }

    func setupPhase1() {
        var bar : Bar!
        var spike : Spike!
        var interruptor : Interruptor!

        bar = makeBar(150)
        bar.position = CGPointMake(300, 400)
        bar.zRotation = 1.5;

        bar = makeBar(100)
        bar.position = CGPointMake(240, 320)
        bar.zRotation = 0;
        bar.physicsBody?.restitution = 0.5

        spike = makeSpike()
        spike.position = CGPointMake(160, 310)

        bar = makeBar(120)
        bar.position = CGPointMake(70, 320)
        bar.zRotation = 0;
    }

    func setupPhase2() {

    }

    func setupPhase3() {

    }

    var spikeId = 0
    func makeSpike() -> Spike {
        let spike = Spike()
        spike.name = "spike\(spikeId)"
        addChild(spike)
        spikeId++
        return spike
    }

    var interruptorId = 0
    func makeInterruptor() -> Interruptor {
        let interruptor = Interruptor()
        interruptor.name = "interruptor\(interruptorId)"
        addChild(interruptor)
        interruptorId++
        return interruptor
    }

    var barId = 0
    func makeBar(width: CGFloat) -> Bar {
        let bar = Bar(width: width)
        bar.name = "bar\(barId)"
        addChild(bar)
        barId++
        return bar
    }

    func didBeginContact(contact: SKPhysicsContact) {
        if(contact.bodyA.categoryBitMask != BallCategory && contact.bodyB.categoryBitMask != BallCategory) {
            NSLog("no ball")
            return
        }

        if(contact.bodyA.categoryBitMask == BarCategory || contact.bodyB.categoryBitMask == BarCategory) {
            NSLog("bar")
            return
        }

        var interruptor : Interruptor?
        if (contact.bodyA.categoryBitMask == InterruptorCategory) {
            interruptor = contact.bodyA.node as! Interruptor?
        } else if (contact.bodyB.categoryBitMask == InterruptorCategory) {
            interruptor = contact.bodyB.node as! Interruptor?
        }

        if interruptor != nil {
            interruptor?.spike?.removeFromParent()
            return
        }

        var spike : Spike?
        if (contact.bodyA.categoryBitMask == InterruptorCategory) {
            spike = contact.bodyA.node as! Spike?
        } else if (contact.bodyB.categoryBitMask == InterruptorCategory) {
            spike = contact.bodyB.node as! Spike?
        }

        if spike != nil {
            fatalError("you die")
        }

        var goal : Goal?
        if (contact.bodyA.categoryBitMask == GoalCategory) {
            goal = contact.bodyA.node as! Goal?
        } else if (contact.bodyB.categoryBitMask == GoalCategory) {
            goal = contact.bodyB.node as! Goal?
        }

        if goal != nil {
            println("goal")
        }
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
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
