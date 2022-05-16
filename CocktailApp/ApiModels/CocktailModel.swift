//
//  CocktailModel.swift
//  CocktailApp
//
//  Created by Sebulla on 16/05/2022.
//

import Foundation


struct CocktailResults: Codable {
    let drinkName: String
    let imageString: String
    
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    
    let instructions: String
 
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
        case imageString = "strDrinkThumb"
        
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        
        case instructions = "strInstructions"
    }
}

struct DrinksResults: Codable {
    let drinks: [CocktailResults]
}
