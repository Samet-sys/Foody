//
//  FavouritesCell.swift
//  Foody
//
//  Created by Samet Alkan on 24.02.2024.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
   
    @IBOutlet weak var cellFoodNameLabel: UILabel!
    @IBOutlet weak var cellPriceLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    var foodsRepo = FoodsDaoRespository()
    var favFood:Foods?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //--- food name label config ---
        cellFoodNameLabel?.font = UIFont(name: "Epilogue", size: 20)
        
        //--- imageview config ---
        cellImageView?.layer.cornerRadius = cellImageView.frame.size.height / 2
        cellImageView?.clipsToBounds = true //picture rounded
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteButton(_ sender: Any) {
        if let favFood = favFood{
            foodsRepo.deleteFavItem(food_id: favFood.food_id!)
        }
        //MARK: buradan silindiğinde anasayfadaki kalp işareti kalksın
    }
    
    
    
}
