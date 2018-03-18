//
//  massangersSetupCell.swift
//  WashMe
//
//  Created by Артур on 18.03.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//


import UIKit
class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    
}

class IconsView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 17, y: 60, width:330, height: 100)
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
      
        cv.alwaysBounceHorizontal = true
       
        layout.scrollDirection = .horizontal
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
       
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        return cv
    }()
    
    
    let cellid = "cellid"
    
    
    let settings: [Setting] = {
        return [ Setting(name: "WhatsApp", imageName: "whatsappLogo.png"),
                Setting(name: "Mail", imageName: "mailIcon.png")]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellid)
        addSubview(collectionView)
        
       
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        collectionView.leftAnchor.constraint(equalTo:leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        
        
        
      
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! MenuCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
        
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class  MenuCell: UICollectionViewCell {
    
    var setting: Setting? {
        didSet {
            IconLabel.text = setting?.name
           if let imageName = setting?.imageName
           {
            imageView.image = UIImage(named:imageName)
            }
        }
    }
    
    let imageView: UIImageView = {
        let imagev = UIImageView()
        imagev.image = UIImage(named: "whatsappLogo.png")
        imagev.translatesAutoresizingMaskIntoConstraints = false
      imagev.contentMode = .scaleAspectFit
        imagev.backgroundColor = .clear
        

        
        
        return imagev
    }()
    
    let IconLabel: UILabel = {
        let label = UILabel()
        label.text = "WhatsApp"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.75)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
       backgroundColor = .clear

        setupViews()
      
      
    }
    
    
    func setupViews () {
        
        addSubview(imageView)
     
        addSubview(IconLabel)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor ,constant: 0 ).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 5 ).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -25 ).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        IconLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3.5).isActive = true
        IconLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        IconLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
