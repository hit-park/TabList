//
//  ViewController.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/10.
//

import UIKit

class ViewController: UIViewController {
    
    private var tabCV: TabVC = .init()
    private let model: Model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tabCV.view)
        tabCV.view.translatesAutoresizingMaskIntoConstraints = false
        tabCV.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabCV.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabCV.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        model.completion = { [weak self] (res) in
            self?.tabCV.update(data: res)
        }
    }

}
