//
//  GrayCloudsAnimation.swift
//  WashMe
//
//  Created by Артур on 05.03.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit
class Clouds2 {
    static func get(with cloudsimage: UIImage) -> CAEmitterLayer {
        let clouds = CAEmitterLayer()
        clouds.emitterShape = kCAEmitterLayerLine
        clouds.emitterCells = generateEmitterCellsForClouds2(with: cloudsimage)
        
        return clouds
    }
    
    static func generateEmitterCellsForClouds2(with cloudsimage: UIImage) -> [CAEmitterCell] {
        var clouds = [CAEmitterCell] ()
        
        let cloud = CAEmitterCell ()
        
        cloud.contents = cloudsimage.cgImage
        cloud.birthRate = 0.05
        cloud.lifetime = 150
        cloud.velocity = CGFloat(11)
        cloud.emissionLongitude = (90 * (.pi/180))
        cloud.alphaRange = 0.9
        
        cloud.scale = 0.3
        
        cloud.scaleRange = 0.1
        clouds.append(cloud)
        
        return clouds
    }
    
    
    
}


