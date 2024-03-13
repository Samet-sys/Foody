//
//  MainPageViewModel.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation
import RxSwift

class MainPageViewModel{
    var foodsList = BehaviorSubject<[Foods]>(value: [Foods]())
    var foodsRepo = FoodsDaoRespository()
    
    init() {
        self.foodsList = foodsRepo.foodsList
        loadFoodstoPage()
    }
    
    func loadFoodstoPage(){
        foodsRepo.loadFoodstoPage()
    }
    

    
}
