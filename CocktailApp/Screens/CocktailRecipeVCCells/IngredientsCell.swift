//
//  IngredientsCell.swift
//  CocktailApp
//
//  Created by Sebulla on 15/05/2022.
//

import UIKit

class IngredientsCell: UICollectionViewCell {

    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIngredientLabel(text: String) {
        ingredientLabel.text = text
    }
    
    private func setUpViews() {
        
        contentView.addSubview(ingredientLabel)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        ingredientLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        ingredientLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
}
