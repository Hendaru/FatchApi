//
//  ContentView.swift
//  FatchApiApp
//
//  Created by Hendaru on 18/12/23.
//

import SwiftUI

struct MoviesResponse: Decodable {
    let results: [Movie]
}

struct MoviesView: View {
  @StateObject var viewModel = MoviesViewModel()
    var body: some View {
        Group{
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error) :
                Text(error.localizedDescription)
            case .loaded(let movies):
               list(of: movies)
            }
            
        }
        .navigationTitle("Upcomming Movie")
        .task {
            await viewModel.loadMovies()
        }
    }
    
    @ViewBuilder
    func list(of movies:[Movie])-> some View{
        if movies.isEmpty == false {
            
            List(movies){
                movie in
                NavigationLink{
                    MovieDetailsView(movie: movie)
                }label: {
                    HStack {
                        AsyncImage(url: movie.posterURL){
                            image in image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                        ProgressView()
                        }.frame(width: 80)
                        VStack(alignment: .leading) {
                            Text(movie.title).font(.headline)
                            Text(movie.overview)
                                .lineLimit(4)
                                
                        }
                    }.padding()
                }
                
                
            }
        }else{
            Text("No Upcomming Movie")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoviesView()
        }
    }
}
