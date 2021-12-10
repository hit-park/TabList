//
//  GridView.swift
//  TabList
//
//  Created by 박희태 on 2021/12/02.
//

import UIKit
import RxSwift

class GridView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cv: _CV = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : _CV           = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor         = .init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        fl.scrollDirection          = .horizontal
        fl.minimumLineSpacing       = 1
        fl.minimumInteritemSpacing  = 1
        fl.sectionInset             = .init(top: 1, left: 1, bottom: 1, right: 1)
        return _cv
    }()
    
    private let vLine: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        return view
    }()
    
    private var items: [ICategoryV2] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cv)
        cv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(vLine)
        vLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vLine.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        cv.register(GridItemCell.self, forCellWithReuseIdentifier: "GridItemCell")
        cv.delegate   = self
        cv.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(items: [ICategoryV2]) -> CGFloat {
        let rows    : Double  = ceil(Double(items.count) / 2.0)
        let height  : Double  = (rows * 40.0) + (rows + 1.0)
        self.items = items
        self.cv.reloadData()
        return CGFloat(height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridItemCell", for: indexPath) as? GridItemCell else { return UICollectionViewCell() }
        cell.lbTitle.text = self.items[indexPath.item].title
        cell.ivArrow.image = UIImage(named: "iconArrowMoreLine2")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 43) / 2, height: 40)
    }
    
}
