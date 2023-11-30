//
//  NetworkManager.swift
//  RxSwiftPetProject
//
//  Created by Денис Набиуллин on 24.11.2023.
//

import RxSwift
import RxCocoa

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func loadRandomDogImages(count: Int) -> Observable<[String]> {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/\(count)") else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                do {
                    let categoriesData = try JSONDecoder().decode(DataStruct.self, from: data)
                    return categoriesData.message
                } catch {
                    throw NetworkError.decodingFailed
                }
            }
            .catchAndReturn([])
            .asObservable()
    }
}
