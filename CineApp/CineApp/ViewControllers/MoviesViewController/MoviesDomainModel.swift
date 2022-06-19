//
//  MoviesDomainModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 18.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

protocol MoviesDomainModelDelegate: class {
    func fetchedPopularMoviesList(popularMoviesList: [MovieUIModel])
    func fetchedNowPlayingMoviesList(nowplayingMoviesList: [MovieUIModel])
}

class MoviesDomainModel {
    
    var popularMovies = [MovieUIModel]()
    var nowPlayingMovies = [MovieUIModel]()
    weak var delegate: MoviesDomainModelDelegate?
    
    init(delegate: MoviesDomainModelDelegate) {
        self.delegate = delegate
    }
    
    func getPopularMoviesList() {
        TmDBService.instance.getPopularMovies(completion: { popularMovies in
            for movie in popularMovies {
                let movieUIModel = MovieUIModel(poster_path: movie.poster_path ?? "", id: movie.id ?? 0, title: movie.title ?? "" , vote_average: String(movie.vote_average ?? 0), overview: movie.overview ?? "", release_date: movie.release_date ?? "", runtime: "", genres: "", backdrop_path: movie.backdrop_path ?? "", favorite: false )
                self.popularMovies.append(movieUIModel)
                
                TmDBService.instance.getMovieDetail(id: movieUIModel.id ?? 0) { movieDetail in
                    movieUIModel.runtime = String(movieDetail.runtime)
                    var genrePopular: String = ""
                    for (index, genre) in movieDetail.genres.enumerated() {
                        if movieDetail.genres.count-1 == index {
                            genrePopular += genre.name
                        } else {
                            genrePopular += genre.name + ", "
                        }
                    }
                    movieUIModel.genres = genrePopular
                }
            }
            self.delegate?.fetchedPopularMoviesList(popularMoviesList: self.popularMovies)
        })
    }
    
    func getNowPlayingMoviesList(){
        TmDBService.instance.getNowPlayingMovies(completion: { nowPlayingMovies in
            for movie in nowPlayingMovies {
                let movieUIModel = MovieUIModel(poster_path: movie.poster_path ?? "", id: movie.id ?? 0, title: movie.title ?? "", vote_average: String(movie.vote_average ?? 0), overview: movie.overview ?? "", release_date: movie.release_date ?? "", runtime: "", genres: "", backdrop_path: movie.backdrop_path ?? "", favorite: false)
                self.nowPlayingMovies.append(movieUIModel)
                TmDBService.instance.getMovieDetail(id: movieUIModel.id ?? 0) { (detailModel) in
                    var genreNowPlaying: String = ""
                    for(index, genre) in detailModel.genres.enumerated(){
                        movieUIModel.runtime = String(detailModel.runtime)
                        if detailModel.genres.count-1 == index {
                            genreNowPlaying += genre.name
                        } else{
                            genreNowPlaying += genre.name + ", "
                        }
                        movieUIModel.genres = genreNowPlaying
                    }
                }
            }
            self.delegate?.fetchedNowPlayingMoviesList(nowplayingMoviesList: self.nowPlayingMovies)
        })
    }    
}
