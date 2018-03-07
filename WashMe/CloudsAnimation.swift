//
//  CloudsAnimation.swift
//  WashMe
//
//  Created by Артур on 10.02.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit
class Clouds {
    static func get(with cloudsimage: UIImage) -> CAEmitterLayer {
        let clouds = CAEmitterLayer()
        clouds.emitterShape = kCAEmitterLayerLine
        clouds.emitterCells = generateEmitterCellsForClouds(with: cloudsimage)
        
        return clouds
    }
    
    
    static func generateEmitterCellsForClouds(with cloudsimage: UIImage) -> [CAEmitterCell] {
        var clouds = [CAEmitterCell] ()
        
        let cloud = CAEmitterCell ()
        cloud.contents = cloudsimage.cgImage
        cloud.birthRate = 0.05
        cloud.lifetime = 150
        cloud.velocity = CGFloat(11)
        cloud.emissionLongitude = (90 * (.pi/180))
        cloud.alphaRange = 0.4
        cloud.scale = 0.6
        
        cloud.scaleRange = 0.2
        clouds.append(cloud)
        
        return clouds
    }
    
    
    
}

