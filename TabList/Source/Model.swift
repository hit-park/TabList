//
//  Model.swift
//  TabList
//
//  Created by sunyoung.jung on 2021/11/11.
//

import Foundation
import Alamofire

struct ICategoryV2: Equatable, Codable {
    let available    : Bool
    let desc         : String?
    let icon         : String?
    let id           : Int
    let items        : [ICategoryV2]?
    let title        : String
    let areaAvailable: Bool
}

class Model {
    
    enum UpdateType {
        case Tab
        case List
        case All
    }
    
    private let URL             : String = "https://joy.yanolja.com/v6-6/leisure/categories/v2"
    private var entity          : [ICategoryV2]?
    private var selectedTabIdx  : Int = 0
    
    var data    : [ICategoryV2]? { entity }
    var tabIdx  : Int            { selectedTabIdx }
    
    var completion: ((UpdateType) -> Void)?
    
    init() {
        AF.request(URL, method: .get).response { [weak self] res in
            switch res.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode([ICategoryV2].self, from: data!)
                    self?.entity = json
                    self?.completion?(.All)
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            case .failure(_):
                break
            }
        }
    }
    
    func update(_ type: UpdateType, tabIdx: Int) {
        selectedTabIdx = tabIdx
        completion?(type)
    }
    
}
