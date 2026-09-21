//
//  MenuItem.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

struct MenuItem: Decodable {
    let title:String
    let image:String
    let price:String
    let descr:String
    let category:String
    
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case price
        case descr = "description"
        case category
    }
}
