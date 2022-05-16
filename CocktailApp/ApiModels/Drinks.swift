//
//  Drinks.swift
//  CocktailApp
//
//  Created by Sebulla on 15/05/2022.
//

import Foundation

class Drinks {
    
    struct Drink: Codable {
        var strDrink: String
    }
    struct Returned: Codable {
        var drinks: [Drink]
    }
    
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=rum"
    var drinkArray: [Drink] = []
    
    func getData(completed: @escaping () -> ()) {
        print("accessing url string \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("error couldnt create \(urlString)")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.drinkArray =  returned.drinks
            } catch {
                print(" json error: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
