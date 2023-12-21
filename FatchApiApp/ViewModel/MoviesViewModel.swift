//
//  MoviesViewModel.swift
//  FatchApiApp
//
//  Created by Hendaru on 19/12/23.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject{
    enum State{
        case loading
        case loaded(movies:[Movie])
        case error(Error)
    }
    
//    @Published var movies:[Movie] = []
    
    @Published var state: State = .loading

    
    let service = MoviesService()
    
    func loadMovies() async{
        do{
            
          let movies = try await service.getMoviesFromApi()
            state = .loaded(movies: movies)
            
        }catch{
            state = .error(error)
        }
    }
}
