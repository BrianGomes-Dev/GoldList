//
//  ViewController.swift
//  GoldList
//
//  Created by Brian Gomes on 17/11/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activitiesView: UIView!
    @IBOutlet weak var activitiesLbl: UILabel!
    @IBOutlet weak var foodLbl: UILabel!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var shopsView: UIView!
    @IBOutlet weak var shopsLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    
    var ActivitiesData = ["Sports","Climbing","Treking"]
    var ActivitiesImg = [ #imageLiteral(resourceName: "pint-of-beer"),#imageLiteral(resourceName: "fast-food"),#imageLiteral(resourceName: "cupcake")]
    var categoryDataArr : [categoryData] = []
    var selectedCategory = ""
    var searchedData:[String] = []
    
    var categoryStatus = 1
    // 1 = activities
    // 2 = Food and drink
    // 3 = Shops
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
      setCollectionView()
        resizeCVs()
        setGestures()
        ActivitiesClicked()
        
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        searchTableView.alpha = 0
        
    }
   
    func insertActivitiesData(){
        categoryDataArr.removeAll()
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "ferris-wheel"), catName: "Theme Park", catID: "amusement_park"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "aquarium"), catName: "Aquarium", catID: "aquarium"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "macaw"), catName: "Zoo", catID: "zoo"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "library"), catName: "Library", catID: "library"))
        
    }
    func insertFoodsData(){
        categoryDataArr.removeAll()
        
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "fast-food"), catName: "Restaurant", catID: "restaurant"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "pint-of-beer"), catName: "Pub", catID: "bar"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "cupcake"), catName: "Bakery", catID: "bakery"))
      
    }
    func insertShopsData(){
        
        categoryDataArr.removeAll()
        
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "mortar"), catName: "Spa", catID: "spa"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "online-shop"), catName: "Electronics", catID: " electronics_store"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "store"), catName: "Supermarket", catID: "supermarket"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "repair-shop"), catName: "Hardware", catID: "hardware_store"))
        categoryDataArr.append(categoryData(catImg: #imageLiteral(resourceName: "bag"), catName: "Travel", catID: "travel_agency"))
        
    }
    
    func setGestures(){
        activitiesView.isUserInteractionEnabled = true
        let activitiesGesture = UITapGestureRecognizer(target: self, action: #selector(ActivitiesClicked))
        activitiesView.addGestureRecognizer(activitiesGesture)
        
        foodView.isUserInteractionEnabled = true
        let foodGesture = UITapGestureRecognizer(target: self, action: #selector(foodClicked))
        foodView.addGestureRecognizer(foodGesture)
        
        shopsView.isUserInteractionEnabled = true
        let shopGesture = UITapGestureRecognizer(target: self, action: #selector(shopClicked))
        shopsView.addGestureRecognizer(shopGesture)
    }
    
    @objc func ActivitiesClicked()
    {
        categoryStatus = 1
        insertActivitiesData()
        activitiesLbl.textColor = #colorLiteral(red: 0.7191421986, green: 0.5696715117, blue: 0.3770875037, alpha: 1)
        shopsLbl.textColor = UIColor.white
        foodLbl.textColor = UIColor.white
        
        collectionView.reloadData()
    
    }
    
    @objc func foodClicked()
    {
        categoryStatus = 2
        insertFoodsData()
        foodLbl.textColor = #colorLiteral(red: 0.7191421986, green: 0.5696715117, blue: 0.3770875037, alpha: 1)
        shopsLbl.textColor = UIColor.white
        activitiesLbl.textColor = UIColor.white
        collectionView.reloadData()
    }
    
    @objc func shopClicked()
    {
        categoryStatus = 3
        insertShopsData()
        shopsLbl.textColor = #colorLiteral(red: 0.7191421986, green: 0.5696715117, blue: 0.3770875037, alpha: 1)
        activitiesLbl.textColor = UIColor.white
        foodLbl.textColor = UIColor.white
        collectionView.reloadData()
    }

    
}

//MARK:- COLLECTIONVIEW FUNCTIONS
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDataArr.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCells
        
    
        
        cell.setData(Image: categoryDataArr[indexPath.row].catImg, Name: categoryDataArr[indexPath.row].catName)
        
        

        return cell
    }
    

    
    func resizeCVs(){
//        let collectnLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let mult = self.view.bounds.size.width * 0.46
//        collectnLayout.itemSize = CGSize(width: mult, height: mult * 1.6)
//        view.layoutIfNeeded()
    }
    
    func setCollectionView(){
 
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName:"CategoryCells" , bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
                    return CGSize.init(width: (screenWidth-25) / 3, height: (screenWidth-25) / 3 * 1.5)
    }    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                let maps = storyBoard.instantiateViewController(withIdentifier: "mapsVC") as! MapsVC
        
       // maps.selectedCategory = categoryDataArr[indexPath.row].catID
        maps.selectedCategory = categoryStatus
               
                self.present(maps, animated: true, completion: nil)
        
        
    }
}



//MARK:- SEARCHBAR FUNCTIONS

extension ViewController:UISearchBarDelegate{
    
    
    
    func setUpSearchBar(){
            searchBar.delegate = self as UISearchBarDelegate
          
            searchBar.placeholder = "Search Category or Business"
            if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
                textfield.backgroundColor = UIColor.white
                
            }
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           
            view.endEditing(true)
        
            if searchBar.text == ""{
                print("SearchBar Empty")
                searchBar.placeholder = "Type a place name"
                
            }
            else if searchBar.text == "Library" {
                searchedData.append("Library")
                let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                        let maps = storyBoard.instantiateViewController(withIdentifier: "mapsVC") as! MapsVC
                
               // maps.selectedCategory = categoryDataArr[indexPath.row].catID
                maps.selectedCategory = categoryStatus
                
                       
                        self.present(maps, animated: true, completion: nil)
            
            } else if searchBar.text == "Bakery" {
                searchedData.append("Bakery")
                let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                        let maps = storyBoard.instantiateViewController(withIdentifier: "mapsVC") as! MapsVC
                
               // maps.selectedCategory = categoryDataArr[indexPath.row].catID
                maps.selectedCategory = categoryStatus
                
                       
                        self.present(maps, animated: true, completion: nil)
            
            }
            else if searchBar.text == "Supermarket" {
                searchedData.append("Supermarket")
                let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                        let maps = storyBoard.instantiateViewController(withIdentifier: "mapsVC") as! MapsVC
                
               // maps.selectedCategory = categoryDataArr[indexPath.row].catID
                maps.selectedCategory = categoryStatus
                
                       
                        self.present(maps, animated: true, completion: nil)
            }
}
    
 
    
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchTableView.reloadData()
        searchTableView.alpha = 0
        print("Search Ended")
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchTableView.reloadData()
        if searchedData.count == 0{
            searchTableView.alpha = 0
        }else{
            searchTableView.alpha = 1
        }
      
        print("Search Started")
        return true
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        cell.selectionStyle = .none
        cell.searchText.text = searchedData[indexPath.row]
        return cell
    }
    
    
    
    
    
    
}
