//
//  CompletionAndCombine.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import Foundation
import Combine

func makeClassicNetworkCall(_ completion: @escaping (MovieResponse) -> Void) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
    
    URLSession
        .shared
        .dataTask(with: url) { data, _, _ in
            let decoded = try! jsonDecoder.decode(MovieResponse.self, from: data!)
            
            completion(decoded)
        }
        .resume()
}

func makeNetworkCallWithCombine() -> AnyPublisher<MovieResponse, Never> {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!

    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
        .replaceError(with: MovieResponse(results: []))
        .eraseToAnyPublisher()
}
