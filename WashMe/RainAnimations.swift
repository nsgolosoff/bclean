//
//  RainAnimations.swift
//  WashMe
//
//  Created by Артур on 10.02.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit

class Rain {
    
    static func get(with image: UIImage) -> CAEmitterLayer {
        let rain = CAEmitterLayer()
        rain.emitterShape = kCAEmitterLayerLine
        rain.emitterCells = generateEmitterCells(with: image)
        
        return rain
    }
    
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        var cells = [CAEmitterCell] ()
        
        let cell = CAEmitterCell ()
        cell.contents = image.cgImage
        //cell.alphaRange = 0.8
        cell.birthRate = 600
        cell.lifetime = 50
        cell.velocity = CGFloat(250)
        cell.velocityRange = 70

        cell.emissionLongitude = (180 * (.pi/180))
        cell.yAcceleration = CGFloat(10)
        cell.scale = 0.2
        cell.alphaRange = 0.8
        cell.scaleRange = 0.1
        
        cells.append(cell)
        
        return cells
    }
    
    
    
}

