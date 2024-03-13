//
//  FoodsDaoRespository.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import Foundation
import RxSwift
import Alamofire
import FirebaseFirestore

class FoodsDaoRespository{
    var collectionFavorites = Firestore.firestore().collection("Favorites")
    var foodsList = BehaviorSubject<[Foods]>(value: [Foods]())
    var cartFoodsList = BehaviorSubject<[Cart]>(value: [Cart]())
    var FavFoodsList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    //--- main page methods ---
    func loadFoodstoPage(){
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            if let data = response.data {
                do{
                    let jsonResponse = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    if let list = jsonResponse.foods {
                        self.foodsList.onNext(list)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

    //--- details page methods ---
    func addToCart(food_name:String, food_pic_name:String, food_price:String, food_order_count:String, user_name:String){
        let params:Parameters = ["yemek_adi":food_name, "yemek_resim_adi":food_pic_name, "yemek_fiyat":food_price, "yemek_siparis_adet":food_order_count, "kullanici_adi":user_name]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response {response in
            if let data = response.data{
                do{
                    let jsonResponse = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Başarı : \(jsonResponse.success!)")
                    print("Mesaj  : \(jsonResponse.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    //--- Cart page methods ---
    
    func loadFoodstoCart(user_name:String){
        let params:Parameters = ["kullanici_adi":user_name]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response {response in
            if let data = response.data{
                do{
                    let jsonResponse = try JSONDecoder().decode(CartResponse.self, from: data)
                    if let list = jsonResponse.cart_foods{
                        self.cartFoodsList.onNext(list)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteCartItem(user_name:String, cart_food_id:Int){
        let params:Parameters = ["kullanici_adi": user_name, "sepet_yemek_id":cart_food_id]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response {response in
            if let data = response.data{
                do{
                    let jsonResponse = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Başarı : \(jsonResponse.success!)")
                    print("Mesaj  : \(jsonResponse.message!)")
                    self.loadFoodstoCart(user_name: "ASA")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    //MARK: -FoodsCell Favorites ADD and DELETE
    
    func addToFav(selectedFood:Foods){
        let newFav: [String:Any] = ["fav_food_id":"", "food_name":selectedFood.food_name as Any, "food_pic_name":selectedFood.food_pic_name as Any, "food_price":selectedFood.food_price as Any ]
        collectionFavorites.document().setData(newFav)
    }
    
    func deleteFavItem(food_id:String){
        collectionFavorites.document(food_id).delete()
    }
    
    func loadFavsToPage(){
        collectionFavorites.addSnapshotListener{snapshot, error in
            var favsList = [Foods]()
            if let documents = snapshot?.documents{
                for document in documents{
                    let data = document.data()
                    let food_id = document.documentID
                    let food_name = data["food_name"] as? String ?? ""
                    let food_pic_name = data["food_pic_name"] as? String ?? ""
                    let food_price = data["food_price"] as? String ?? ""
                    
                    let favFood = Foods(food_id: food_id, food_name: food_name, food_pic_name: food_pic_name, food_price: food_price)
                    favsList.append(favFood)
                    
                }
            }
            self.FavFoodsList.onNext(favsList)
        }
    }
}
