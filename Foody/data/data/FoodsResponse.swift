//
//  FoodsResponse.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation

class FoodsResponse : Decodable {
    var foods:[Foods]?
    var succes:Int?
    
    enum CodingKeys: String, CodingKey {
        case foods = "yemekler"
      }
    
}
