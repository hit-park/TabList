//
//  TabCell.swift
//  TabList
//
//  Created by 박희태 on 2021/11/30.
//

import UIKit

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
