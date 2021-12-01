//
//  ContentView.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var loadingTask: Task<Void, Never>?
    
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
            loadingTask = Task {
                movies = await makeAsyncNetworkCall().results
            }
        }
        .onDisappear {
            loadingTask?.cancel()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
