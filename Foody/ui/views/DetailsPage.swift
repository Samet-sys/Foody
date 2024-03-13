//
//  DetailsPage.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import UIKit
import Cosmos
import Kingfisher

class DetailsPage: UIViewController {

    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepperButton: UIStepper!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var detailsFoodNameLabel: UILabel!
    var food:Foods?
    var detailsPageVM = DetailsPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //--- overview starts ---
        func configure(with starRating: Double) {
            //star count
            starRatingView.rating = starRating
            
            //Unchangable stars
            starRatingView.settings.updateOnTouch = false
        }
        //--- stepper label ---
        stepperLabel.text = "1"
        //--- stepper button config ---
        stepperButton?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stepperButton?.layer.cornerRadius = 10
        //--- image view confid ---
        detailsImageView.layer.cornerRadius = 100
        detailsImageView.clipsToBounds = true
        //---
        if let foodData = food {
            detailsFoodNameLabel.text = foodData.food_name
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(foodData.food_pic_name!)"){
                DispatchQueue.main.async {
                    self.detailsImageView.kf.setImage(with: url)
                }
                
            }
            
            
        }

    }
   
    @IBAction func addtoCartButton(_ sender: Any) {
        
        detailsPageVM.addToCart(food_name: food!.food_name!, food_pic_name: food!.food_pic_name!, food_price: food!.food_price!, food_order_count:String(Int(stepperButton.value)), user_name: "ASA")
    }
    
    @IBAction func stepperButton(_ sender: Any) {
        stepperLabel.text = String(Int(stepperButton.value))
    }
    
    @IBAction func favButton(_ sender: Any) {
        
    }
}
