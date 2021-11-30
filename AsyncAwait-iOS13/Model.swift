//
//  Model.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import Foundation

let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"

struct Movie: Decodable, Equatable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    var posterURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)")!
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()
