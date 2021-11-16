//
//  TabVC.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/16.
//

import UIKit

class TabCell: UICollectionViewCell {

    let lbTitle: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lbTitle)
        lbTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lbTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        lbTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        lbTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TabVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let cv: UICollectionView = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : UICollectionView       = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor = .red
        fl.estimatedItemSize = CGSize(width: 50, height: 40)
        fl.scrollDirection = .horizontal
        return _cv
    }()
    
    private var entity: [ICategoryV2]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cv)
        cv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cv.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
        cv.delegate     = self
        cv.dataSource   = self
    }
    
    func update(data: [ICategoryV2]) {
        entity = data
        cv.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entity?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let info = entity?[indexPath.item],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as? TabCell
        else { return UICollectionViewCell() }
        cell.lbTitle.text = info.title
        return cell
    }
}
