//
//  StepsHeader.swift
//  CocktailApp
//
//  Created by Sebulla on 15/05/2022.
//

import UIKit

final class StepsHeader: UICollectionReusableView {
    
    private lazy var stepsLabel: UILabel = {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        stepsLabel.text = title
    }
    
    private func setupViews() {
        
        addSubview(stepsLabel)
        stepsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        stepsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stepsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        stepsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
}
