//
//  CartCell.swift
//  Foody
//
//  Created by Samet Alkan on 23.02.2024.
//

import UIKit
protocol CheckButtonLabel {
    func changeButtonLabel(price:Int)
}
class CartCell: UITableViewCell {
    
    
    @IBOutlet weak var stepperButton: UIStepper!
    @IBOutlet weak var cellStepperLabel: UILabel!
    @IBOutlet weak var cellFoodNameLabel: UILabel!
    @IBOutlet weak var cellPriceLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    var oldStepperValue:Int?
    var delegate:CheckButtonLabel?
    var cartFood:Cart?
    var stepperCount = 1
    var cartPageVM = CartPageViewModel()
    var cartRepo = FoodsDaoRespository()
    
    var page_VM:CartPageViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        //--- food name label config ---
        cellFoodNameLabel?.font = UIFont(name: "Epilogue", size: 20)
        //--- stepper button config ---
        stepperButton?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stepperButton?.layer.cornerRadius = 10
        //--- imageview config ---
        cellImageView?.layer.cornerRadius = cellImageView.frame.size.height / 2
        cellImageView?.clipsToBounds = true //picture rounded
        
                        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cellStepper(_ sender: Any) {
        
        cellStepperLabel.text = String(Int(stepperButton.value))
        //--- change price in cell with stepper button ---
        var price = 0
        var addedPrice = 0
        if let cart = cartFood{
            if let foodPrice = Int(cart.food_price!), let foodOrderCount = Int(cellStepperLabel.text!) {
                price = foodPrice * foodOrderCount
                addedPrice = foodPrice * (foodOrderCount - oldStepperValue!)
            }
            cellPriceLabel.text = "$\(addedPrice)"
        }
        delegate?.changeButtonLabel(price: price)
    }
    @IBAction func deleteButton(_ sender: Any) {
        
        if let cart = cartFood, let foodID = Int(cart.cart_food_id!) {
            cartPageVM.deleteCartItem(user_name: cart.user_name!, cart_food_id: foodID)
        }
        
    }
    
}

