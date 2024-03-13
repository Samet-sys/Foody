//
//  FavoritesPageViewModel.swift
//  Foody
//
//  Created by Samet Alkan on 11.03.2024.
//

import Foundation
import RxSwift

class FavoritesPageViewModel{
    
    var foodsRepo = FoodsDaoRespository()
    var FavFoodsList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    init() {
        FavFoodsList = foodsRepo.FavFoodsList
        loadFavsToPage()
    }
    
    func loadFavsToPage(){
        foodsRepo.loadFavsToPage()
        
    }
    
}
