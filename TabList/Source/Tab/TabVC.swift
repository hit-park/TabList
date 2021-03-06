//
//  TabVC.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/16.
//

import UIKit

class TabVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        view.backgroundColor = .init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    private let vSelectline: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        return view
    }()
    
    var model: Model!
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
                let frame: CGRect = self.cv.cellForItem(at: .init(item: self.model.tabIdx, section: 0))?.frame
            else { return }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.vSelectline.frame = CGRect(x: frame.minX, y: frame.height - 2, width: frame.width, height: 2)
                }
            }
        }
    }
    
    func update() {
        cv.reloadData()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let info = model.data?[indexPath.item],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as? TabCell
        else { return UICollectionViewCell() }
        cell.lbTitle.text = info.title
        cell.update(isSelected: model.tabIdx == indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TabCell.fittingSize(title: model.data?[indexPath.item].title ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idx: Int = indexPath.item
        guard model.tabIdx != idx else { return }
        selected?(idx)
        cv.reloadData()
    }
}
