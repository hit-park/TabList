//
//  ListItemHeader.swift
//  TabList
//
//  Created by 박희태 on 2021/12/08.
//

import UIKit

class ListItemHeader: UICollectionReusableView {
    
    private let vContainer: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iv: UIImageView = {
        let _iv: UIImageView = .init()
        _iv.translatesAutoresizingMaskIntoConstraints = false
        _iv.contentMode = .scaleAspectFill
        return _iv
    }()
    
    let lbTitle: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let lbDesc: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    let ivArrow: UIImageView = {
        let _iv: UIImageView = .init()
        _iv.translatesAutoresizingMaskIntoConstraints = false
        _iv.contentMode = .scaleAspectFill
        return _iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(vContainer)
        vContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        vContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        vContainer.addSubview(iv)
        iv.leftAnchor.constraint(equalTo: vContainer.leftAnchor, constant: 20).isActive = true
        iv.topAnchor.constraint(equalTo: vContainer.topAnchor, constant: 12).isActive = true
        iv.bottomAnchor.constraint(equalTo: vContainer.bottomAnchor, constant: -12).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        vContainer.addSubview(lbTitle)
        lbTitle.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 12).isActive = true
        lbTitle.topAnchor.constraint(equalTo: vContainer.topAnchor, constant: 12).isActive = true

        vContainer.addSubview(lbDesc)
        lbDesc.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 12).isActive = true
        lbDesc.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 2).isActive = true
        lbDesc.bottomAnchor.constraint(equalTo: vContainer.bottomAnchor, constant: -12).isActive = true

        vContainer.addSubview(ivArrow)
        ivArrow.leftAnchor.constraint(equalTo: lbTitle.rightAnchor, constant: 12).isActive = true
        ivArrow.leftAnchor.constraint(equalTo: lbDesc.rightAnchor, constant: 12).isActive = true
        ivArrow.rightAnchor.constraint(equalTo: vContainer.rightAnchor, constant: -20).isActive = true
        ivArrow.centerYAnchor.constraint(equalTo: vContainer.centerYAnchor).isActive = true
        ivArrow.widthAnchor.constraint(equalToConstant: 16).isActive = true
        ivArrow.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iv.image        = nil
        lbTitle.text    = nil
        lbDesc.text     = nil
        ivArrow.image   = nil
    }
}
