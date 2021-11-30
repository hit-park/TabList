//
//  MainVC.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/10.
//

import UIKit

class MainVC: UIViewController {
    
    private let tabVC : TabVC  = .init()
    private let listVC: ListVC = .init()
    private let model : Model  = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tabVC.view)
        tabVC.view.translatesAutoresizingMaskIntoConstraints = false
        tabVC.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabVC.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tabVC.model = model
        
        view.addSubview(listVC.view)
        listVC.view.translatesAutoresizingMaskIntoConstraints = false
        listVC.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listVC.view.topAnchor.constraint(equalTo: tabVC.view.bottomAnchor).isActive = true
        listVC.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        listVC.model = model
        
        model.completion = { [weak self] (type) in
            switch type {
            case .Tab:
                self?.tabVC.update()
            case .List:
                self?.listVC.update()
            case .All:
                self?.tabVC.update()
                self?.listVC.update()
            }
        }
        tabVC.selected = { [weak self] idx in self?.model.update(.List, tabIdx: idx) }
        listVC.scroll  = { [weak self] idx in self?.model.update(.Tab, tabIdx: idx)  }
    }

}
