//
//  FoodsCell.swift
//  Foody
//
//  Created by Samet Alkan on 22.02.2024.
//

import UIKit
import Cosmos

protocol Star{
    func changeStar()
}

enum Favorite{
    case selected
    case nonSelected
}
class FoodsCell: UICollectionViewCell, Star {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var cellPriceLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    var favoriteStatue:Favorite?
    var foodsRepo = FoodsDaoRespository()
    var selectedFood:Foods?
    var favFoods:[Foods]?
    var favCell = FavouritesCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
        setupRoundedCorners()
        favCell.delegate = self // bunlar olmadan da işe yarıyor ??
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientBackground()
        favCell.delegate = self
    }
    
    func changeStar() {
        favoriteStatue = .nonSelected
        
    }
 
     //--- configure overview stars ---
     override public func prepareForReuse() {
         // Ensures the reused cosmos view is as good as new
         starRatingView.prepareForReuse()
       }
 
     func configure(with starRating: Double) {
         //star count
         starRatingView.rating = starRating
         
         //Unchangable stars
         //starRatingView.settings.updateOnTouch = false
     }
    
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.23).cgColor, UIColor.white.withAlphaComponent(0)]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1) // Aşağıdan
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.25) // Yukarıya
        gradientLayer.frame = bounds
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = contentView.layer.sublayers?[0] as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
        starRatingView.frame.size.width = contentView.frame.size.width / 2
    }
       

    func setupRoundedCorners() {
            contentView.layer.cornerRadius = 10 // Yuvarlak köşe yarıçapını ayarla
            contentView.layer.masksToBounds = true
        }
    

    @IBAction func addToFavoritesButton(_ sender: Any) {
        if favoriteStatue == .selected {
            favoriteStatue = .nonSelected
            addToFavoritesButton.tintColor = .white

            if let favFoods = favFoods{
                for food in favFoods{
                   
                    if food.food_name! == selectedFood!.food_name{
                        
                        foodsRepo.deleteFavItem(food_id: food.food_id!)
                    }
                }
                
                
            }
            
        }else {
            favoriteStatue = .selected
            addToFavoritesButton.tintColor = UIColor(named: "Main")
            if let selectedFood = selectedFood{
                foodsRepo.addToFav(selectedFood: selectedFood)
            }
        }
    }
    
}
