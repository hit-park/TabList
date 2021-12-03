//
//  LIstItemCell.swift
//  TabList
//
//  Created by 박희태 on 2021/12/01.
//

import UIKit

class ListItemCell: UICollectionViewCell {
    
    let iv: UIImageView = {
        let _iv: UIImageView = .init()
        _iv.translatesAutoresizingMaskIntoConstraints = false
        _iv.contentMode = .scaleAspectFill
//        _iv.backgroundColor = .red
        return _iv
    }()
    
    let lbTitle: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .bold)
//        label.backgroundColor = .green
        return label
    }()
    
    let lbDesc: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
//        label.backgroundColor = .blue
        return label
    }()
    
    let ivArrow: UIImageView = {
        let _iv: UIImageView = .init()
        _iv.translatesAutoresizingMaskIntoConstraints = false
        _iv.contentMode = .scaleAspectFill
//        _iv.backgroundColor = .brown
        return _iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .orange
//        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        contentView.addSubview(iv)
        iv.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        iv.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        iv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
//        iv.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        contentView.addSubview(lbTitle)
        lbTitle.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 12).isActive = true
        lbTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true

        contentView.addSubview(lbDesc)
        lbDesc.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 12).isActive = true
        lbDesc.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 2).isActive = true
        lbDesc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true

        contentView.addSubview(ivArrow)
        ivArrow.leftAnchor.constraint(equalTo: lbTitle.rightAnchor, constant: 12).isActive = true
        ivArrow.leftAnchor.constraint(equalTo: lbDesc.rightAnchor, constant: 12).isActive = true
        ivArrow.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        ivArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        ivArrow.widthAnchor.constraint(equalToConstant: 16).isActive = true
        ivArrow.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iv.image = nil
        lbTitle.text = nil
        lbDesc.text = nil
        ivArrow.image = nil
    }
}
