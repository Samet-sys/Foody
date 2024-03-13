//
//  FavoritesPageViewController.swift
//  Foody
//
//  Created by Samet Alkan on 22.02.2024.
//

import UIKit


class FavoritesPage: UIViewController {

    @IBOutlet weak var favouritesTableView: UITableView!
    var favFoods = [Foods]()
    var favoritesPageViewModel = FavoritesPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
       
        navgationBarConfigure()
        
        _ = favoritesPageViewModel.FavFoodsList.subscribe(onNext: { list in
            self.favFoods = list
            DispatchQueue.main.async {
                self.favouritesTableView.reloadData()
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favToDetails"{
            if let dataFood = sender as? Foods{
                let destinationVC = segue.destination as! DetailsPage
                destinationVC.food = dataFood
            }
        }
    }
    
    func navgationBarConfigure(){
        self.navigationItem.title = "My Favourites"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor(named: "Main")!, .font : UIFont(name: "Epilogue", size: 22)!]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
}

extension FavoritesPage : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favFoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favList = favFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouritesCell", for: indexPath) as! FavouritesCell
        cell.cellFoodNameLabel.text = favList.food_name
        cell.cellPriceLabel.text = "$\(favList.food_price!)"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(favList.food_pic_name!)") {
            DispatchQueue.main.async {
                cell.cellImageView.kf.setImage(with: url)
            }
        }
        cell.favFood = favList
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = favFoods[indexPath.row]
        performSegue(withIdentifier: "favToDetails", sender: food)
        
    }
}
