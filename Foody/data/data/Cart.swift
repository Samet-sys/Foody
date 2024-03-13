//
//  Cart.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation

class Cart : Decodable{
    var cart_food_id:String?
    var food_name:String?
    var food_pic_name:String?
    var food_price:String?
    var food_order_count:String?
    var user_name:String?
    
    enum CodingKeys: String, CodingKey {
        case cart_food_id = "sepet_yemek_id"
        case food_name = "yemek_adi"
        case food_pic_name = "yemek_resim_adi"
        case food_price = "yemek_fiyat"
        case food_order_count = "yemek_siparis_adet"
        case user_name = "kullanici_adi"
      }
    
    init() {
        
    }
    init(cart_food_id: String, food_name: String, food_pic_name: String, food_price: String, food_order_count: String, user_name: String) {
        self.cart_food_id = cart_food_id
        self.food_name = food_name
        self.food_pic_name = food_pic_name
        self.food_price = food_price
        self.food_order_count = food_order_count
        self.user_name = user_name
    }
}
