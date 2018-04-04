//
//  WalkThruPageCell.swift
//  WashMe
//
//  Created by Артур on 28.03.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
   let contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"rainyDay")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
        }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Только вчера помыли свою машину,\nа уже сегодня она грязная?"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let mainText: UITextView = {
        let text = UITextView()
        text.text = "Не беда! Наше приложение подскажет вам когда именно стоит помыть машину, чтобы избежать подобной ситуации, сохранив свои деньги и время."
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 15)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.isEditable = false
        text.isSelectable = false
//        text.isScrollEnabled = false
        text.backgroundColor = .clear
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        settingUpConstraints()
    }
    
    private func settingUpConstraints() {
        
        addSubview(contentImage)
        addSubview(headerLabel)
        addSubview(mainText)
        
        contentImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        contentImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        contentImage.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        
        headerLabel.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 17).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        mainText.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        mainText.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        mainText.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        mainText.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -60).isActive = true

        
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
