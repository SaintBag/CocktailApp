//
//  CocktailSearchVC.swift
//  CocktailApp
//
//  Created by Sebulla on 14/05/2022.
//

import UIKit
import DropDown

class CocktailSearchVC: UICollectionViewController {
    
    var cocktailResultController = CocktailResultController()
    var cocktails: [CocktailResults] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var drinks: [IngredientSearch] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var cocktail: CocktailResults?
    
    private lazy var searchBar = UISearchBar()
    private lazy var dropButton = DropDown()
    //    private lazy var drinks: [String] = ["apple","appear","Azhar","code","BCom"]
//    private lazy var allDrinks = Drinks()
    private lazy var drinksFiltered: [IngredientSearch] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData() 
            }
        }
    }
    private let cellID = "cellID"
    
    init() {
        super.init(collectionViewLayout: CocktailSearchVC.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiguration()
        whichButtonWasPushed(searchTerm: searchBar.text ?? "")
        drinksFiltered = drinks
        
    }
    
    private func viewConfiguration() {
        self.view.backgroundColor = .white
        titleConfiguration()
        configureSearchBarUI()
        dropDownConfguration()
        setupCollectionView()
    }
    
    private func dropDownConfguration() {
        
        dropButton.anchorView = searchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.backgroundColor = .white
        dropButton.direction = .bottom
        
        dropButton.selectionAction = { [weak self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)") //Selected item: code at index: 0
        }
    }
    private func titleConfiguration() {
        self.navigationController?.navigationBar.topItem?.title = "Cocktail App"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func whichButtonWasPushed(searchTerm: String) {
            
        cocktailResultController.searchCocktailByIngredient(searchTerm: searchTerm) { (result) in
                    do {
                        let drinks = try result.get()
                        DispatchQueue.main.async {
                            self.drinks = drinks.drinks
                        }
                    } catch {
                        print(result)
                    }
                }
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(drinksFiltered.count)
        if cocktails.count <= 0 {
            return drinks.count
        } else {
            return cocktails.count
        }
    }
    //drinks.drinkArray[indexPath.row].strDrink
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CocktailCell
                cell.backgroundColor = .systemPink
        //        cell.setRecipeTitleLabel(title: drinks[indexPath.row].drinkName)
        if cocktails.count <= 0 {
            let drink = drinks[indexPath.row].drinkName
            cell.setRecipeTitleLabel(title: drink)
        } else {
            let drink = cocktails[indexPath.row].drinkName
            let image = cocktails[indexPath.row].imageString
            cell.setRecipeTitleLabel(title: drink)
            cell.setRecipeImage(image: UIImage.init(named: image)!) //TODO: how to set image uisng api
            
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = CocktailRecipeVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            let fraction: CGFloat = 1
            let spacing: CGFloat = 5
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(fraction/7))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            
            return section
        }
    }
}

extension CocktailSearchVC {
    
    private func configureSearchBarUI() {
        
        searchBarSetup()
        showSearchBarButton(schouldShow: true)
    }
    
    private func searchBarSetup() {
        
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search by ingredients e.g Vodka"
        searchBar.tintColor = .black
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
    }
}

extension CocktailSearchVC: UISearchBarDelegate {
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    //    drinks.drinkArray : drinks.drinkArray.filter
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        drinksFiltered = searchText.isEmpty ? drinks : drinks.filter({ (dat) -> Bool in
            dat.drinkName.range(of: searchText, options: .caseInsensitive) != nil
        })
        guard let searchTerm = searchBar.text else { return }
        self.whichButtonWasPushed(searchTerm: searchTerm)
        dropButton.dataSource = [searchTerm]
        dropButton.show()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: 
        let aString = "first last"
        let newString = aString.replacingOccurrences(of: " ", with: "_")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(schouldShow: false)
    }
    
    func showSearchBarButton(schouldShow: Bool) {
        if schouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "magnifyingglass"),
                style: .plain,
                target: self,
                action: #selector(handleShowSearch))
            navigationItem.rightBarButtonItem?.tintColor = .white
            navigationItem.rightBarButtonItem?.width = 20
        } else {
            navigationItem.rightBarButtonItem = nil
            drinksFiltered = drinks
            dropButton.hide()
        }
    }
    
    @objc func handleShowSearch() {
        search(schouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func search(schouldShow: Bool) {
        showSearchBarButton(schouldShow: !schouldShow)
        searchBar.showsCancelButton = schouldShow
        searchBar.showsSearchResultsButton = schouldShow
        navigationItem.titleView = schouldShow ? searchBar : nil
    }
}
