//
//  ListPageCell.swift
//  TabList
//
//  Created by 박희태 on 2021/11/30.
//

import UIKit

class ListPageCell: UICollectionViewCell {
    
    private let cv: _CV = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : _CV           = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor     = .white
        fl.scrollDirection      = .vertical
        fl.minimumLineSpacing   = 12
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
        
        cv.register(ListItemHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ListItemHeader")
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

extension ListPageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListItemHeader", for: indexPath) as? ListItemHeader else { return UICollectionReusableView() }
        DispatchQueue.global().async { [weak self] in
            guard
                let self = self,
                let urlString = self.items[indexPath.section].icon,
                let url = URL(string: urlString)
            else { return }
            if let data = try? Data(contentsOf: url) {
               DispatchQueue.main.async {
                   header.iv.image = UIImage(data: data)
               }
            }
        }
        header.lbTitle.text  = self.items[indexPath.section].title
        header.lbDesc.text   = self.items[indexPath.section].desc
        header.ivArrow.image = UIImage(named: "iconArrowMoreLine2")
        header.click = { print("header.click") }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListItemCell", for: indexPath) as? ListItemCell else { return UICollectionViewCell() }
        let _ = cell.update(items: items[indexPath.section].items ?? [])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56 + 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ListItemCell.fittingSize(items: items[indexPath.section].items ?? [])
    }
    
}
