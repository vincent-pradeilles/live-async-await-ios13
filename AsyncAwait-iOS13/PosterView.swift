//
//  PosterView.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import SwiftUI

extension Movie {
    var posterImage: UIImage {
        get async {
            let (data, _) = try! await URLSession.shared.data(from: self.posterURL)
            
            return UIImage(data: data)!
        }
    }
}

struct PosterView: View {
    
    let movie: Movie
    
    @State var posterImage: UIImage? = nil
    
    var body: some View {
        if let posterImage = posterImage {
            Image(uiImage: posterImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        } else {
            ActivityIndicator()
                .frame(width: 100)
                .onAppear {
                    Task {
                        posterImage = await movie.posterImage
                    }
                }
        }
    }
}
