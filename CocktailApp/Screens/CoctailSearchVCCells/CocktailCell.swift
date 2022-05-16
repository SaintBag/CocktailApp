//
//  CocktailCell.swift
//  CocktailApp
//
//  Created by Sebulla on 14/05/2022.
//

import UIKit

class CocktailCell: UICollectionViewCell {
    lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans", size: 16)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRecipeImage(image: UIImage) {
        recipeImageView.image = image
    }
    
    func setRecipeTitleLabel(title: String) {
        recipeTitleLabel.text = title
    }
    
    private func setConstrains() {
        
        contentView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        contentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        recipeTitleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
    }
}
