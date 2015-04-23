//
//  Common.swift
//  jotajota
//
//  Created by Jose Alcalá-Correa on 23/04/15.
//  Copyright (c) 2015 XING. All rights reserved.
//

import UIKit
import SpriteKit

let BallCategory : UInt32 = 1 << 0
let InterruptorCategory : UInt32 = 1 << 1
let BarCategory : UInt32 = 1 << 2
let SpikeCategory : UInt32 = 1 << 3
let GoalCategory : UInt32 = 1 << 4

let CollidableCategory = BallCategory | BarCategory | SpikeCategory
let NonCollidableCategory : UInt32 = 0
