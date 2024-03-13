//
//  CartPageViewModel.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation
import RxSwift

class CartPageViewModel{
    var foodsRepo = FoodsDaoRespository()
    var cartFoodsList = BehaviorSubject<[Cart]>(value: [Cart]())
    
    init() {
        cartFoodsList = foodsRepo.cartFoodsList
    }
    init(user_name:String) {
        cartFoodsList = foodsRepo.cartFoodsList
        loadFoodstoCart(user_name: user_name)
    }
    func loadFoodstoCart(user_name:String){
        foodsRepo.loadFoodstoCart(user_name:user_name)
        
    }
    
    func deleteCartItem(user_name:String, cart_food_id:Int){
        foodsRepo.deleteCartItem(user_name: user_name, cart_food_id: cart_food_id)
        
        cartFoodsList = foodsRepo.cartFoodsList
        //Note: Changes in cartFoodsList is observed in REPO and assigned those changes here only when init method is called. So we have to get new changes from REPO every changes happened. That's why we assign cartFoodsList = foodsRepo.cartFoodsList
        
    }
        
    
}
