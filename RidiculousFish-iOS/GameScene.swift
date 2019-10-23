//
//  GameScene.swift
//  RidiculousFish-iOS
//
//  Created by Simran Kaur Bal on 2019-10-22.
//  Copyright © 2019 Simran Kaur Bal. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    var greenbush:SKSpriteNode!
    var bush:SKSpriteNode!
    var hanger:SKSpriteNode!
    var fish:[SKSpriteNode] = []
    
    override func didMove(to view: SKView)
    {
    
        
        // movement for greenbushes- animation
        let moveAction1 = SKAction.moveBy(x: 0, y: 10, duration: 1)
        let moveAction2 = SKAction.moveBy(x: 0, y: -20, duration: 1)
        
        self.enumerateChildNodes(withName: "greenbush")
        {
            (node, stop) in
            self.greenbush = node as! SKSpriteNode
            let waterAnimation = SKAction.sequence([moveAction1,moveAction2,moveAction1])
            
            let waterforever = SKAction.repeatForever(waterAnimation)
            self.greenbush.run(waterforever)
        }
        
        // movement for pink bush- animation
        let moveAction3 = SKAction.moveBy(x: 10, y: 0, duration: 1)
        let moveAction4 = SKAction.moveBy(x: -20, y: 0, duration: 1)
    
        self.enumerateChildNodes(withName: "bush")
        {
            (node, stop) in
            self.bush = node as! SKSpriteNode
            let waterAnimation = SKAction.sequence([moveAction3,moveAction4,moveAction3])
            
            let waterforever = SKAction.repeatForever(waterAnimation)
            self.bush.run(waterforever)
        }
        

        func spawnfish()
        {
         // generating fishes
            let randomFish = Int(CGFloat.random(in: 1 ... 8))
            let fishs:SKSpriteNode = SKSpriteNode(imageNamed: "fish\(randomFish)")
            
            // generate random position
            let randomXPos = CGFloat.random(in: -100 ... 0)
            let randomYPos = CGFloat.random(in: 0 ... size.height/2-50)
            fishs.position = CGPoint(x: randomXPos, y: randomYPos)
            print("fish\([randomFish])")
            
            // adding the fish onto screen
            addChild(fishs)
            
            // pushing fishs in array
            self.fish.append(fishs)
        }
        
        
        
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
