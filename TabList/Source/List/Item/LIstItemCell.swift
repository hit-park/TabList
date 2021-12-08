//
//  LIstItemCell.swift
//  TabList
//
//  Created by 박희태 on 2021/12/01.
//

import UIKit

class ListItemCell: UICollectionViewCell {
 
    let vGrid: GridView = {
        let view: GridView = .init()
        view.backgroundColor = .green
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(vGrid)
        vGrid.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        vGrid.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vGrid.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        vGrid.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func update(items: [ICategoryV2]) -> CGFloat {
        return vGrid.update(items: items)
    }
    
    static func fittingSize(items: [ICategoryV2]) -> CGSize {
        let calcCell = ListItemCell()
        let height: CGFloat = calcCell.update(items: items)
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
}
