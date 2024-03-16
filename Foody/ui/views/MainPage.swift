//
//  ViewController.swift
//  Foody
//
//  Created by Samet Alkan on 21.02.2024.
//

import UIKit
import Kingfisher
import RxSwift

class MainPage: UIViewController {
  

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodsCollectionView: UICollectionView!
    var foodsList = [Foods]()
    var mainPageVM = MainPageViewModel()
    
    var favFoods = [Foods]()
    var favoritesPageViewModel = FavoritesPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //delegates
        searchBar.delegate = self
        foodsCollectionView.delegate = self
        foodsCollectionView.dataSource = self
        
        navigationConfiguration()
        searchbarConfiguration()
        collectionViewConfiguration()
        tabBarConfiguration()
        
        _ = mainPageVM.foodsList.subscribe(onNext: { list in
            self.foodsList = list
            DispatchQueue.main.async {
                self.foodsCollectionView.reloadData()
            }
        })
        
        _ = favoritesPageViewModel.FavFoodsList.subscribe(onNext: { list in
            self.favFoods = list
            DispatchQueue.main.async {
                self.foodsCollectionView.reloadData()
            }
        })
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsPage"{
            if let dataFood = sender as? Foods{
                let destinationVC = segue.destination as! DetailsPage
                destinationVC.food = dataFood
            }
        }
    }
    func collectionViewConfiguration(){
        foodsCollectionView.backgroundColor = .clear
        let collectionViewDesign = UICollectionViewFlowLayout()
        collectionViewDesign.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewDesign.minimumInteritemSpacing = 10
        collectionViewDesign.minimumLineSpacing = 10
        
        //10 X 10 X 10 = 30
        let screenWidth = UIScreen.main.bounds.width
        let itemsWidth = (screenWidth - 50) / 2
        
        collectionViewDesign.itemSize = CGSize(width: itemsWidth, height: itemsWidth*1.2)
        
        foodsCollectionView.collectionViewLayout = collectionViewDesign
    }
    
    func searchbarConfiguration(){
        searchBar.searchTextField.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        //placeholder text color, text font and text string changes
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search your favourites...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0.7, alpha: 0.5), .font : UIFont(name: "Epilogue", size: 16)!])
        //search icon color changes
        searchBar.searchTextField.leftView?.tintColor = UIColor.white
        //transparent background
        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = .clear
        
        searchBar.searchTextField.textColor = UIColor(named: "Main")
        searchBar.searchTextField.font = UIFont(name: "Epilogue", size: 15)
    }
    
    func navigationConfiguration(){
         self.navigationItem.title = "FOODY"
         let appearance = UINavigationBarAppearance()
         appearance.configureWithTransparentBackground()
         appearance.largeTitleTextAttributes = [.foregroundColor : UIColor(named: "Main")!, .font : UIFont(name: "Epilogue", size: 22)!]
         navigationController?.navigationBar.barStyle = .black
         navigationController?.navigationBar.standardAppearance = appearance
         navigationController?.navigationBar.compactAppearance = appearance
         navigationController?.navigationBar.scrollEdgeAppearance = appearance
         navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        
    }
    
    func tabBarConfiguration(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarItemColorConfigure(itemAppearance: tabBarAppearance.stackedLayoutAppearance)
        tabBarItemColorConfigure(itemAppearance: tabBarAppearance.inlineLayoutAppearance)
        tabBarItemColorConfigure(itemAppearance: tabBarAppearance.compactInlineLayoutAppearance)
        
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        
    }
    
    func tabBarItemColorConfigure(itemAppearance:UITabBarItemAppearance){
        itemAppearance.selected.iconColor = UIColor(named: "Main")
        //itemAppearance.selected.badgeBackgroundColor = UIColor.systemMint
       
        itemAppearance.normal.iconColor = UIColor(named: "AccentColor")
        //itemAppearance.normal.badgeBackgroundColor = UIColor.lightGray
    }

    

}

extension MainPage : UISearchBarDelegate{
    
}

extension MainPage : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodsList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let foodlist = foodsList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foods_cell", for: indexPath) as! FoodsCell
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(foodlist.food_pic_name!)") {
            DispatchQueue.main.async {
                cell.cellImageView.kf.setImage(with: url)
            }
        }
        let labelFont = UIFont(name: "Epilogue", size: 17)
        let labelColor = UIColor(named: "AccentColor")
        cell.cellLabel.text = foodlist.food_name
        cell.cellLabel.font = labelFont
        cell.cellLabel.textColor = labelColor
        
        cell.cellPriceLabel.text = "$" + foodlist.food_price!
        cell.cellPriceLabel.font = labelFont?.withSize(20)
        cell.cellPriceLabel.textColor = labelColor
        cell.configure(with: 4)
        for food in favFoods{
            if food.food_name == foodlist.food_name{
                cell.favoriteStatue = .selected
                cell.addToFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.addToFavoritesButton.tintColor = UIColor(named: "Main")
                break
            }else{
                cell.favoriteStatue = .nonSelected
                cell.addToFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.addToFavoritesButton.tintColor = .white
                
            }
        }
        
        cell.selectedFood = foodlist
        cell.favFoods = favFoods
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foodsList[indexPath.row]
        performSegue(withIdentifier: "detailsPage", sender: food)
        
    }
    
}


