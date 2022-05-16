//
//  CocktailResponse.swift
//  CocktailApp
//
//  Created by Sebulla on 16/05/2022.
//

import Foundation

import Foundation
import UIKit

class CocktailResultController {

    var cocktailResults: DrinksResults?
    var ingredientResults: IngredientDrinks?

    enum NetworkError: Error {
        case otherError(Error)
        case noData
        case decodeFailed
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case pull = "PULL"
        case delete = "DELETE"
    }
    
    enum Endpoints {
        static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
        case getImage(String)
        case searchByName(String)

        case searchByIngredient(String)
        
        var stringValue: String {
            switch self {
            case .getImage(let imagePath):
                return imagePath
            case .searchByName(let searchTerm):
                return Endpoints.baseURL + "search.php?s=\(searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            case .searchByIngredient(let searchTerm):
                return Endpoints.baseURL + "filter.php?i=\(searchTerm)"
            }
        }
        var url: URL {
            // TODO: error when enter space
            return URL(string: stringValue)!
        }
    }
    
    func downloadCocktailImage(path: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        var request = URLRequest(url: Endpoints.getImage(path).url)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    func searchCocktailByName(searchTerm: String, completion: @escaping (Result<DrinksResults, NetworkError>) -> Void) {
        var request = URLRequest(url: Endpoints.searchByName(searchTerm).url)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            let decoder = JSONDecoder()
            do {
                self.cocktailResults = try decoder.decode(DrinksResults.self, from: data)
                completion(.success(self.cocktailResults!))
            } catch  {
                completion(.failure(.decodeFailed))
                return
            }
        }.resume()
    }
    
    func searchCocktailByIngredient(searchTerm: String, completion: @escaping (Result<IngredientDrinks, NetworkError>) -> Void) {
        var request = URLRequest(url: Endpoints.searchByIngredient(searchTerm).url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.ingredientResults = try decoder.decode(IngredientDrinks.self, from: data)
                completion(.success(self.ingredientResults!))
            } catch  {
                completion(.failure(.decodeFailed))
                return
            }
        }.resume()
    }
}
