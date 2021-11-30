//
//  TabVC.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/16.
//

import UIKit

class TabVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let spacing: CGFloat = 20
    
    class _CV: UICollectionView {
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
        let _cv : _CV           = .init(frame: .zero, collectionViewLayout: fl)
        _cv.translatesAutoresizingMaskIntoConstraints = false
        _cv.backgroundColor         = .white
        fl.scrollDirection          = .horizontal
        fl.minimumInteritemSpacing  = 20
        fl.sectionInset             = .init(top: 0, left: 20, bottom: 0, right: 20)
        return _cv
    }()
    
    private let vUnderline: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        return view
    }()
    
    private let vSelectline: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        return view
    }()
    
    private var entity: [ICategoryV2]?
    private var selectedTabIdx: Int = 0
    
    var selected: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cv)
        cv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(vUnderline)
        vUnderline.topAnchor.constraint(equalTo: cv.bottomAnchor).isActive = true
        vUnderline.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vUnderline.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vUnderline.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        vUnderline.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(vSelectline)
        
        cv.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
        cv.delegate     = self
        cv.dataSource   = self
        cv.completion { [weak self] in
            guard
                let self = self,
                let frame: CGRect = self.cv.cellForItem(at: .init(item: self.selectedTabIdx, section: 0))?.frame
            else { return }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.vSelectline.frame = CGRect(x: frame.minX, y: frame.height - 2, width: frame.width, height: 2)
                }
            }
        }
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
        cell.update(isSelected: selectedTabIdx == indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TabCell.fittingSize(title: entity?[indexPath.item].title ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idx: Int = indexPath.item
        guard selectedTabIdx != idx else { return }
        selectedTabIdx = idx
        selected?(idx)
        cv.reloadData()
    }
}


class TabCell: UICollectionViewCell {

    let lbTitle: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func update(isSelected: Bool) {
        switch isSelected {
        case true:
            lbTitle.textColor = .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
            lbTitle.font = .systemFont(ofSize: 12, weight: .bold)
        case false:
            lbTitle.textColor = .init(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
            lbTitle.font = .systemFont(ofSize: 12, weight: .regular)
        }
    }
        
    override func prepareForReuse() {
        lbTitle.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
