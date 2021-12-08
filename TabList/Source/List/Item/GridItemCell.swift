//
//  GridItemCell.swift
//  TabList
//
//  Created by 박희태 on 2021/12/03.
//

import UIKit

class GridItemCell: UICollectionViewCell {
    
    let lbTitle: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .green
        return label
    }()
    
    let ivArrow: UIImageView = {
        let _iv: UIImageView = .init()
        _iv.translatesAutoresizingMaskIntoConstraints = false
        _iv.contentMode = .scaleAspectFill
        _iv.backgroundColor = .brown
        return _iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        
        contentView.addSubview(lbTitle)
        lbTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        lbTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        contentView.addSubview(ivArrow)
        ivArrow.leftAnchor.constraint(equalTo: lbTitle.rightAnchor, constant: 4).isActive = true
        ivArrow.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        ivArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        ivArrow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        ivArrow.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbTitle.text = nil
        ivArrow.image = nil
    }
}
