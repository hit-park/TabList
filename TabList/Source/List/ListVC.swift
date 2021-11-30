//
//  ListVC.swift
//  TabList
//
//  Created by 박희태 on 2021/11/30.
//

import UIKit

class ListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private class _CV: UICollectionView {
        private var completion: (() -> Void)?
            
        func completion(_ complete: @escaping () -> Void) {
            completion = complete
            super.reloadData()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if let block = completion {
                block()
            }
        }
    }
    
    private let cv: _CV = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : _CV                        = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor = .white
        _cv.isPagingEnabled = true
        fl.scrollDirection  = .horizontal
        fl.minimumLineSpacing = 0
        return _cv
    }()
    
    var model: Model!
    var scroll: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cv)
        cv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        cv.register(ListCell.self, forCellWithReuseIdentifier: "ListCell")
        cv.delegate     = self
        cv.dataSource   = self
    }
    
    func update() {
        cv.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
//            let info = model.data?[indexPath.item],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell
        else { return UICollectionViewCell() }
        cell.contentView.backgroundColor = getRandomColor()
        return cell
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: cv.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scroll?(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))
    }
}
