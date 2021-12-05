//
//  ContentView.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import SwiftUI

typealias LoadingTask = Task<Void, Never>

struct ContentView: View {
    
    @State var loadingTask: LoadingTask?
    
    @State var movies: [Movie] = []
    
    var body: some View {
        NavigationView {
            List(movies) { movie in
                NavigationLink(destination: {
                    DetailView(movie: movie)
                }, label: {
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
                })
            }
            .navigationBarTitle("Upcomming movies")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
