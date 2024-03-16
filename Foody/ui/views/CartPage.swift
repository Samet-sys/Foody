//
//  CartPage.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import UIKit
import Kingfisher



class CartPage: UIViewController , CheckButtonLabel {
    
    

    @IBOutlet weak var checkoutButtonText: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    
   
    var cartFoods = [Cart]()
    var totalAmount = 0
    var cartPageVM = CartPageViewModel(user_name: "ASA")
    
    var totalPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        //---
        _ = cartPageVM.cartFoodsList.subscribe(onNext: {list in
            self.cartFoods = list
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        })
        
        //--- navigation title configuration ---
        self.navigationItem.title = "My Cart"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor(named: "Main")!, .font : UIFont(name: "Epilogue", size: 22)!]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        //--- checkout button price calculation(BEFORE BUTTON CONFIG) ---
        for i in 0..<cartFoods.count{
            if let price = Int(cartFoods[i].food_price!), let orderCount = Int(cartFoods[i].food_order_count!){
                totalAmount += price * orderCount
            }
            
    
        }
        //--- button text config ---
        checkoutButtonText.setTitle("CHECKOUT ($\(totalAmount))", for: .normal)
        checkoutButtonText.titleLabel?.textColor = UIColor(named: "AccentColor")
        checkoutButtonText.titleLabel?.font = UIFont(name: "Epilogue", size: 14)
        
       
        
        
        

    }
    
    @IBAction func checkoutButton(_ sender: Any) {
    }
    override func viewWillAppear(_ animated: Bool) {
        cartPageVM.loadFoodstoCart(user_name: "ASA")
    }
    
    
}

extension CartPage : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartFoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartList = cartFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartCell
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartList.food_pic_name!)"){
            DispatchQueue.main.async {
                cell.cellImageView.kf.setImage(with: url)
            }
            
        }
        cell.cartFood = cartList
        var price = 0
        if let foodPrice = Int(cartList.food_price!), let foodOrderCount = Int(cartList.food_order_count!) {
                price = foodPrice * foodOrderCount
            }
        cell.cellFoodNameLabel.text = cartList.food_name
        cell.cellPriceLabel.text = "$\(price)"
        cell.cellStepperLabel.text = cartList.food_order_count
        cell.stepperButton.value = Double(cartList.food_order_count!) ?? 0.0
        cell.oldStepperValue = Int(cartList.food_order_count!) ?? 0
        cell.delegate = self
        cell.cartPageVM=cartPageVM
        return cell
    }
    func changeButtonLabel(price: Int) {
        totalAmount += price
        checkoutButtonText.setTitle("CHECKOUT ($\(totalAmount))", for: .normal)
    }
    
    
}
