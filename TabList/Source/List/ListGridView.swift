//
//  ListGridView.swift
//  TabList
//
//  Created by 박희태 on 2021/12/02.
//

import UIKit

class ListGridView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cv: _CV = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : _CV           = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor         = .gray
        fl.scrollDirection          = .horizontal
        fl.minimumLineSpacing       = 1
        fl.minimumInteritemSpacing  = 1
        fl.sectionInset             = .init(top: 1, left: 1, bottom: 1, right: 1)
        return _cv
    }()
    
    private let vLine: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var items: [ICategoryV2] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        cv.delegate = self
        cv.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListItemCell", for: indexPath) as? ListItemCell else { return UICollectionViewCell() }
        
        DispatchQueue.global().async { [weak self] in
            guard
                let self = self,
                let urlString = self.items[indexPath.item].icon,
                let url = URL(string: urlString)
            else { return }
            if let data = try? Data(contentsOf: url) {
               DispatchQueue.main.async {
                   cell.iv.image = UIImage(data: data)
                   
               }
            }
        }
        
        cell.lbTitle.text = self.items[indexPath.item].title
        cell.lbDesc.text = self.items[indexPath.item].desc
        cell.ivArrow.image = UIImage(named: "iconArrowMoreLine2")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
}
