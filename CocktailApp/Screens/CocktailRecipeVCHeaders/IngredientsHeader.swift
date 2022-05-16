//
//  IngredientsHeader.swift
//  CocktailApp
//
//  Created by Sebulla on 15/05/2022.
//

import UIKit

final class IngredientsHeader: UICollectionReusableView {
    
    lazy var recipePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var imageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans", size: 15)
        label.backgroundColor = .init(red: 105/105, green: 105/105, blue: 105/105, alpha: 0.4)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans", size: 25)
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setImageTitleLabel(title: String) {
        imageTitleLabel.text = title
    }
    
    func setTitle(title: String) {
        ingredientsLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(recipePhoto)
        recipePhoto.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        recipePhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        recipePhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(ingredientsLabel)
        ingredientsLabel.topAnchor.constraint(equalTo: recipePhoto.bottomAnchor, constant: 20).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(imageTitleLabel)
        imageTitleLabel.centerXAnchor.constraint(equalTo: recipePhoto.centerXAnchor).isActive = true
        imageTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        imageTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        imageTitleLabel.bottomAnchor.constraint(equalTo: recipePhoto.bottomAnchor).isActive = true
    }
}
