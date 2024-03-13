//
//  DetailsPageViewModel.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation

class DetailsPageViewModel{
    var foodsRepo = FoodsDaoRespository()
    
    func addToCart(food_name:String, food_pic_name:String, food_price:String, food_order_count:String, user_name:String){
        foodsRepo.addToCart(food_name: food_name, food_pic_name: food_pic_name, food_price: food_price, food_order_count: food_order_count, user_name: user_name)
    }
}
