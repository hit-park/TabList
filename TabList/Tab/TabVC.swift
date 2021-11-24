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
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(lbTitle)
        lbTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        lbTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        lbTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        lbTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    static func fittingSize(title: String) -> CGSize {
        let calcCell = TabCell()
        calcCell.lbTitle.text = title
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: 40)
        return calcCell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
        
    override func prepareForReuse() {
        lbTitle.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TabVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cv: UICollectionView = {
        let fl  : UICollectionViewFlowLayout = .init()
        let _cv : UICollectionView           = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor = .red
        fl.scrollDirection = .horizontal
//        fl.minimumLineSpacing = 10
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TabCell.fittingSize(title: entity?[indexPath.item].title ?? "")
    }
}