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

    override func didMove(to view: SKView) {
        super.didMove(to: view)
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
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self;
    }

    func setupBall() {
        ball = Ball()
        ball.position = CGPoint(x: 320, y: frame.size.height)
        self.addChild(ball)
    }

    func setupGoal () {
        goal = Goal()
        goal.position = CGPoint(x: 30, y: 340)
        self.addChild(goal)
    }

    func setupPhase0() {
        var bar = makeBar(width: 200)
        bar.position = CGPoint(x: 320, y: 500)
        bar.zRotation = 0.3

        bar = makeBar(width: 200)
        bar.position = CGPoint(x: 60, y: 470)
        bar.zRotation = -0.2;

        var spike = makeSpike()
        spike.position = CGPoint(x: 190, y: 450)

        var interruptor = makeInterruptor()
        interruptor.position = CGPoint(x: 60, y: 520)
        interruptor.spike = spike

        spike = makeSpike()
        spike.position = CGPoint(x: 20, y: 520)
    }

    func setupPhase1() {
        var bar : Bar!
        var spike : Spike!
        var interruptor : Interruptor!

        bar = makeBar(width: 150)
        bar.position = CGPoint(x: 300, y: 400)
        bar.zRotation = 1.5;

        bar = makeBar(width: 100)
        bar.position = CGPoint(x: 240, y: 320)
        bar.zRotation = 0;
        bar.physicsBody?.restitution = 0.5

        spike = makeSpike()
        spike.position = CGPoint(x: 160, y: 310)

        bar = makeBar(width: 120)
        bar.position = CGPoint(x: 70, y: 320)
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
        spikeId += 1
        return spike
    }

    var interruptorId = 0
    func makeInterruptor() -> Interruptor {
        let interruptor = Interruptor()
        interruptor.name = "interruptor\(interruptorId)"
        addChild(interruptor)
        interruptorId += 1
        return interruptor
    }

    var barId = 0
    func makeBar(width: CGFloat) -> Bar {
        let bar = Bar(width: width)
        bar.name = "bar\(barId)"
        addChild(bar)
        barId += 1
        return bar
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var ball : Ball?
        var other : SKNode?
        if contact.bodyA.categoryBitMask == BallCategory {
            ball = contact.bodyA.node as! Ball?
            other = contact.bodyB.node
        } else if contact.bodyB.categoryBitMask == BallCategory {
            ball = contact.bodyB.node as! Ball?
            other = contact.bodyA.node
        }

        if ball == nil {
            print("No ball in contact, fix categories")
            return
        }

        if let interruptor = other as? Interruptor {
            interruptor.spike?.removeFromParent()
            interruptor.removeFromParent()
        } else if other is Spike {
            let scene = GameOverScene(size: self.size, playerWon:false)
            self.view?.presentScene(scene)
        } else if other is Goal {
            let scene = GameOverScene(size: self.size, playerWon:true)
            self.view?.presentScene(scene)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        self.processUserMotionForUpdate(currentTime)
    }
    
    func processUserMotionForUpdate(_ currentTime: TimeInterval) {
        if let motionData = motionManager!.accelerometerData {
        let acceleration = motionData.acceleration
            if (fabs(acceleration.x) > 0.2 || fabs(acceleration.y) > 0.2) {
                let currentGravity = self.physicsWorld.gravity                
                let finalGravity = CGVector(dx: currentGravity.dx + CGFloat(acceleration.x)*20, dy: currentGravity.dy + CGFloat(acceleration.y)*20)
                physicsWorld.gravity = self.normalizeVector(vector: finalGravity)
            }
        }
    }
    
    func normalizeVector(vector:CGVector) -> CGVector {
    let length = hypotf(Float(vector.dx), Float(vector.dy));
    
    if length == 0 {
        return CGVector(dx: 0, dy: 0);
    }
    
    let scale = 9.8 / length;
    return CGVector(dx: vector.dx * CGFloat(scale), dy: vector.dy * CGFloat(scale));
    }
    
}
