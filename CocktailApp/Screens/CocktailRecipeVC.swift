//
//  CocktailRecipeVC.swift
//  CocktailApp
//
//  Created by Sebulla on 15/05/2022.
//

import UIKit

final class CocktailRecipeVC: UICollectionViewController {
    
    private let sectionHeaderId = "sectionHeaderId"
    private let sectionId = "sectionId"
    private let stepsId = "stepsId"
    private let stepsHeaderId = "stepsHeaderId"
    private let stepsCell = "stepsCell"
    private let ingCell = "ingCell"
    
    init() {
        super.init(collectionViewLayout: CocktailRecipeVC.createViewLayout())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        //        configureUI()
        registerCells()
        //        downloadInstructions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        collectionView.register(IngredientsCell.self, forCellWithReuseIdentifier: ingCell)
        collectionView.register(StepsCell.self, forCellWithReuseIdentifier: stepsCell)
        collectionView.register(IngredientsHeader.self, forSupplementaryViewOfKind: self.sectionHeaderId , withReuseIdentifier: sectionId)
        collectionView.register(StepsHeader.self, forSupplementaryViewOfKind: self.stepsHeaderId , withReuseIdentifier: stepsId)
    }
    
    private static func createViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            let sectionHeaderId = "sectionHeaderId"
            let stepsHeaderId = "stepsHeaderId"
            let spacing: CGFloat = 5
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)))
                item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), elementKind: sectionHeaderId, alignment: .topLeading)
                ]
                
                return section
                
            } else if sectionNumber == 1 {
                
                let estimatedHeight = CGFloat(100)
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
                
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: stepsHeaderId, alignment: .topLeading)
                ]
                return section
            }
            return nil
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 4
       
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionId, for: indexPath) as? IngredientsHeader {
                
                //                let url = URL(string: recipe.image)
                //                header.recipePhoto.kf.setImage(with: url)
                
                let imageTitleLabel = "hello" //recipe.title.uppercased()
                header.setImageTitleLabel(title: imageTitleLabel)
                header.setTitle(title: "INGREDIENTS")
                return header
            }
            
        } else if indexPath.section == 1 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: stepsId, for: indexPath) as? StepsHeader {
                
                header.setTitle(title: "RECIPE STEPS")
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ingCell, for: indexPath) as? IngredientsCell else { return UICollectionViewCell() }
            cell.setIngredientLabel(text: "ingredient")
            //            let ingredient = allIngredients[indexPath.row]
            //            cell.setIngredientLabel(text: ingredient.name.capitalized)
            //            let isAlreadyInBasket = dependencies.dataController.isSaved(ingredient: ingredient)
            //            cell.setButtonState(isSelected: isAlreadyInBasket)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepsCell , for: indexPath) as? StepsCell else { return UICollectionViewCell() }
            
            //            let stepNumber = instructions[indexPath.row].number
            //            let recipeText = instructions[indexPath.row].step
            
//            cell.setTitle(title: "STEP: ")
            cell.setRecipeText(text: "recipeText")
            cell.sizeToFit()
            return cell
        }
        
    }
}
