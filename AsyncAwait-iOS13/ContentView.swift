//
//  ContentView.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var movies: [Movie] = []
    
    var body: some View {
        List(movies) { movie in
            HStack {
                PosterView(movie: movie)
                VStack(alignment:.leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                }
                Spacer()
            }
        }
        .onAppear {
            Task {
                movies = await makeAsyncNetworkCall().results
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
