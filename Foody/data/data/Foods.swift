//
//  Foods.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation

class Foods : Decodable{
    var food_id:String?
    var food_name:String?
    var food_pic_name:String?
    var food_price:String?
    
    enum CodingKeys: String, CodingKey {
        case food_id = "sepet_yemek_id"
        case food_name = "yemek_adi"
        case food_pic_name = "yemek_resim_adi"
        case food_price = "yemek_fiyat"
      }
    
    init() {
        
    }
    init(food_id: String, food_name: String, food_pic_name: String, food_price: String) {
        self.food_id = food_id
        self.food_name = food_name
        self.food_pic_name = food_pic_name
        self.food_price = food_price
    }
}
