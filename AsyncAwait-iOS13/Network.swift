//
//  Network.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import Foundation

func makeAsyncNetworkCall() async -> MovieResponse {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
    
    let (data, _) = try! await URLSession.shared.data(from: url)
    
    return try! jsonDecoder.decode(MovieResponse.self, from: data)
}

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.unknown)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
