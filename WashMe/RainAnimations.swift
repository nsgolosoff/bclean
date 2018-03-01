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
        cell.birthRate = 400
        cell.lifetime = 50
        cell.velocity = CGFloat(600)
        cell.emissionLongitude = (180 * (.pi/180))
        
        cell.scale = 0.04
        cell.scaleRange = 0.06
        cells.append(cell)
        
        return cells
    }
    
    
    
}

