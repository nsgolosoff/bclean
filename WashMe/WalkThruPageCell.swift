//
//  WalkThruPageCell.swift
//  WashMe
//
//  Created by Артур on 28.03.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    private let contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"pisun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//       // addSubview(contentImage)
//        
//        contentImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        contentImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        contentImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        contentImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
