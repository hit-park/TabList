//
//  ListCell.swift
//  TabList
//
//  Created by 박희태 on 2021/11/30.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    private let cv: _CV = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : _CV           = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor         = .white
        fl.scrollDirection          = .vertical
        fl.minimumLineSpacing       = 12
        fl.sectionInset             = .init(top: 12, left: 0, bottom: 12, right: 0)
        return _cv
    }()
    
    var items: [ICategoryV2] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cv)
        cv.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        cv.register(ListItemCell.self, forCellWithReuseIdentifier: "ListItemCell")
        cv.delegate     = self
        cv.dataSource   = self
    }
    
    func update() {
        cv.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        cell.update(items: self.items[indexPath.item].items ?? [])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
