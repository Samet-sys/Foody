//
//  Favorites.swift
//  Foody
//
//  Created by Samet Alkan on 11.03.2024.
//

import Foundation

class Favorites{
    var fav_food_id:String?
    var food_name:String?
    var food_pic_name:String?
    var food_price:String?
    var food_order_count:String?
    var favorites_statue:String?
    
    
    init() {
        
    }
    init(fav_food_id: String, food_name: String, food_pic_name: String, food_price: String, food_order_count: String, favorites_statue: String) {
        self.fav_food_id = fav_food_id
        self.food_name = food_name
        self.food_pic_name = food_pic_name
        self.food_price = food_price
        self.food_order_count = food_order_count
        self.favorites_statue = favorites_statue
    }
}
