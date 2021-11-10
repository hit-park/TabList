//
//  ViewController.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/10.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let URL = "https://joy.yanolja.com/v6-6/leisure/categories/v2"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let af = AF.request(URL, method: .get)
        af.responseJSON { res in
            switch res.result {
            case .success(let value):
                if let jsonObj = value as? [Dictionary<String, Any>] {
                    print(jsonObj)
                }
            case .failure(_):
                break
            }
        }
        
        view.backgroundColor = .red
    }


}

