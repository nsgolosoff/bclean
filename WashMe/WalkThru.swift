//
//  WalkThru.swift
//  WashMe
//
//  Created by Артур on 21.03.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit

struct Page {
    let imageName : String
    let headerText : String
    let mainText : String
}
class  WalkThru: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    let blackview = UIView()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("НАЗАД", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.gray.withAlphaComponent(1), for: .normal)
        button.addTarget(self, action: #selector(scrollToPrevPage), for: .touchUpInside)
        return button
    }()
    

    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ВПЕРЁД", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(scrollToNextPage), for: .touchUpInside)
        return button
    }()
    
    @objc private func scrollToNextPage() {
        let nextIndex = min(pageControl.currentPage + 1, 3)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    @objc private func scrollToPrevPage() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    
    
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.isEnabled = false
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .gray
        pc.pageIndicatorTintColor = .white
        
        return pc
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.backgroundColor = UIColor(red: 53/255, green: 179/255, blue: 247/255, alpha: 1)
        collectionView?.isPagingEnabled = true
        //automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
           collectionView?.contentInsetAdjustmentBehavior = .never
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        setupBottomControls()
        
     
    }
    private let readyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ГОТОВО", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(dismissInfoView), for: .touchUpInside)
        return button
    }()
    
    @objc private func dismissInfoView() {
        
        dismiss(animated: true, completion: nil)
        
    
    }
    
    private func setupBottomControls () {
        let controlStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,nextButton])
        controlStackView.translatesAutoresizingMaskIntoConstraints = false
        controlStackView.distribution = .fillEqually
        view.addSubview(controlStackView)
        view.addSubview(readyButton)
        
        if #available(iOS 11.0, *) {
            controlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5).isActive = true
        } else { controlStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -5).isActive=true
            // Fallback on earlier versions
        }
        controlStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controlStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controlStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        if #available(iOS 11.0, *) {
            readyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 6).isActive = true
        } else { readyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive=true
            // Fallback on earlier versions
        }
        
        readyButton.leftAnchor.constraint(equalTo: nextButton.leftAnchor).isActive = true
        readyButton.rightAnchor.constraint(equalTo: nextButton.rightAnchor).isActive = true
        readyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }
    
   
    
}
