//
//  DetailView.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 05/12/2021.
//

import SwiftUI

struct DetailView: View {
    
    let movie: Movie
    
    @State var data: (credits: [MovieCastMember],
                      reviews: [MovieReview]) = ([], [])
    
    var body: some View {
        List {
            Section(header: Text("Credits")) {
                ForEach(data.credits) { credit in
                    VStack(alignment: .leading) {
                        Text(credit.name)
                            .font(.headline)
                        Text(credit.character)
                            .font(.caption)
                    }
                }
            }
            
            Section(header: Text("Reviews")) {
                ForEach(data.reviews) { review in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(review.author)
                            .font(.headline)
                        Text(review.content)
                            .font(.body)
                    }
                }
            }
        }
        .navigationBarTitle(movie.title)
        .onAppear {
            Task {
                async let credits = getCredits(for: movie)
                async let reviews = getReviews(for: movie)
                
                data = await (credits.cast, reviews.results)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let movie = Movie(id: 580489,
                             title: "Venom: Let There Be Carnage",
                             overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
                             posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg")
    
    static var previews: some View {
        NavigationView {
            DetailView(movie: movie)
        }
    }
}
