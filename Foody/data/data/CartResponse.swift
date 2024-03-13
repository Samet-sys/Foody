//
//  CartResponse.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation

class CartResponse : Decodable{
    var cart_foods:[Cart]?
    var success:Int?
    
    enum CodingKeys: String, CodingKey {
        case cart_foods = "sepet_yemekler"
      }
}
