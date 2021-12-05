//
//  ModelPartTwo.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 05/12/2021.
//

import Foundation

/* Movie Credits */

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCastMember]
}

func getCredits(for movie: Movie) async -> MovieCreditsResponse {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!
    
    let (data, _) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(MovieCreditsResponse.self, from: data)
}

/* Movie Reviews */

struct MovieReview: Identifiable, Equatable, Decodable {
    let id: String
    let author: String
    let content: String
}

struct MovieReviewsResponse: Decodable {
    let results: [MovieReview]
}

func getReviews(for movie: Movie) async -> MovieReviewsResponse {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/reviews?api_key=\(apiKey)")!
    
    let (data, _) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(MovieReviewsResponse.self, from: data)
}
