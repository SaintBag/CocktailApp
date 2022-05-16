//
//  IngredientSearch.swift
//  CocktailApp
//
//  Created by Sebulla on 15/05/2022.
//

import Foundation

struct IngredientSearch: Codable {
    let drinkName: String
    let drinkID: String
    
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
        case drinkID = "idDrink"
    }
}

struct IngredientDrinks: Codable {
    let drinks: [IngredientSearch]
}
