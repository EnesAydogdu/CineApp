//
//  TmDBService.swift
//  CineApp
//
//  Created by Enes Aydogdu on 8.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

class TmDBService {
    
    static let instance = TmDBService()
    
    enum Constants {
        static let baseURL = "https://api.themoviedb.org"
        static let apiKey = "?api_key=85f6ed635a992836f8ba2fd6fb5fa5cb"
        static let movieURL = "/3/movie/"
        static let popularMoviesUrl = Constants.movieURL + "popular"
        static let nowPlayingMoviesUrl = Constants.movieURL + "now_playing"
        static let seriesUrl = "/3/tv/"
        static let topRatedSeriesUrl = Constants.seriesUrl + "top_rated"
        static let popularSeriesUrl = Constants.seriesUrl + "popular"
        static let creditsURL = "/credits"
        static let peopleUrl = "/3/person/"
        static let combinedCreditsUrl = "/combined_credits"
        static let searchingUrl = "/3/search/multi"
        static let searchingQuery = "&query="
        static let tokenUrl = "/3/authentication/token/new"
        static let sessionUrl = "/3/authentication/session/new"
        static let createSessionWithLoginUrl = "/3/authentication/token/validate_with_login"
        static let accountUrl = "/3/account"
        static let favoriteUrl = "/favorite"
        static let sessionIdUrl = "&session_id="
        static let sortByUrl = "&sort_by=created_at.asc"
        static let moviesUrl = "/movies"
        static let accountStatesUrl = "/account_states"
        static let tvShowUrl = "/tv"
    }
    
    var token: String?
    var nowPlayingMovies: Movies?
    var popularMovies: Movies?
    
    func urlBuilder(endPoint: String) -> URL? {
        let url = URL(string: (Constants.baseURL + endPoint + Constants.apiKey))
        return url
    }
    
    func urlBuilderForSearching(endPoint: String, queryNo: String) -> URL? {
        let url = URL(string: (Constants.baseURL + endPoint + Constants.apiKey + Constants.searchingQuery + queryNo))
        return url
    }
    
    func urlBuilderForAccounts(endPoint: String, sessionId: String) -> URL? {
        let url = URL(string: (Constants.baseURL + endPoint + Constants.apiKey + sessionId))
        return url
    }
    
    func getPopularMovies(completion: @escaping ([MovieServiceModel]) -> Void) {
        let popularMoviesUrl = urlBuilder(endPoint: Constants.popularMoviesUrl)
        guard let downloadPopularMoviesUrl = popularMoviesUrl else {return}
        URLSession.shared.dataTask(with: downloadPopularMoviesUrl) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil
                else {
                    return}
            do {
                let decoder = JSONDecoder()
                let popularMoviesList = try decoder.decode(Movies.self, from: data)
                completion(popularMoviesList.results)
            } catch{}
        }.resume()
    }
    
    func getNowPlayingMovies(completion: @escaping ([MovieServiceModel]) -> Void) {
        let nowPlayingMoviesUrl = urlBuilder(endPoint: Constants.nowPlayingMoviesUrl)
        guard let downloadNowPlayingMoviesUrl = nowPlayingMoviesUrl else {return}
        URLSession.shared.dataTask(with: downloadNowPlayingMoviesUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil
                else {
                    return}
            do {
                let decoder = JSONDecoder()
                let nowPlayingMoviesList = try decoder.decode(Movies.self, from: data)
                completion(nowPlayingMoviesList.results)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getMovieDetail(id: Int, completion: @escaping ((MovieDetailsModel) -> Void)) {
        let url = urlBuilder(endPoint: Constants.movieURL + String(id))
        guard let downloadURL = url else { return }
        
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let detail = try decoder.decode(MovieDetailsModel.self, from: data)
                completion(detail)
            } catch {}
        }.resume()
    }
    
    func getPopularSeries(completion: @escaping ([SeriesServiceModel]) -> Void) {
        let popularSeriesUrl = urlBuilder(endPoint: Constants.popularSeriesUrl)
        guard let downloadPopularSeriesUrl = popularSeriesUrl else {return}
        URLSession.shared.dataTask(with: downloadPopularSeriesUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil
                else {
                    return}
            do {
                let decoder = JSONDecoder()
                let popularSeriesList = try decoder.decode(SeriesModel.self, from: data)
                completion(popularSeriesList.results)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getTopRatedSeries(completion: @escaping ([SeriesServiceModel]) -> Void) {
        let nowPlayingSeriesUrl = urlBuilder(endPoint: Constants.topRatedSeriesUrl)
        guard let downloadNowPlayingSeriesUrl = nowPlayingSeriesUrl else {return}
        URLSession.shared.dataTask(with: downloadNowPlayingSeriesUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil
                else {
                    return}
            do {
                let decoder = JSONDecoder()
                let nowPlayingSeriesList = try decoder.decode(SeriesModel.self, from: data)
                completion(nowPlayingSeriesList.results)
            }catch{}
        }.resume()
    }
    
    func getSeriesDetails(id: Int, completion: @escaping ((SeriesDetailModel, SeriesGenreModel) -> Void)){
        let seriesDetailUrl = urlBuilder(endPoint: Constants.seriesUrl + String(id))
        guard let downloadSeriesDetailUrl = seriesDetailUrl else {return}
        
        URLSession.shared.dataTask(with: downloadSeriesDetailUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let detail = try decoder.decode(SeriesDetailModel.self, from: data)
                let genres = try decoder.decode(SeriesGenreModel.self, from: data)
                completion(detail,genres)
            } catch {}
        }.resume()
    }
    
    func getMoviesCredits(id: Int, completion: @escaping ([CreditsServiceModel], [CreditsServiceModel]) -> Void) {
        let moviesCreditsUrl = urlBuilder(endPoint: (Constants.movieURL + String(id) + Constants.creditsURL))
        guard let downloadMoviesCreditsUrl = moviesCreditsUrl else { return }
        
        URLSession.shared.dataTask(with: downloadMoviesCreditsUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let moviesCredits = try decoder.decode(CreditsModel.self, from: data)
                completion(moviesCredits.cast,moviesCredits.crew)
            } catch{}
        }.resume()
    }
    
    func getSeriesCredits(id: Int, completion: @escaping ([CreditsServiceModel], [CreditsServiceModel]) -> Void) {
        let seriesCreditsUrl = urlBuilder(endPoint: (Constants.seriesUrl + String(id) + Constants.creditsURL))
        guard let downloadSeriesCreditsUrl = seriesCreditsUrl else { return }
        
        URLSession.shared.dataTask(with: downloadSeriesCreditsUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let seriesCredits = try decoder.decode(CreditsModel.self, from: data)
                completion(seriesCredits.cast,seriesCredits.crew)
            } catch{}
        }.resume()
    }
    
    func getCreditsDetails(id: Int, completion: @escaping (CreditsDetailsServiceModel) -> Void) {
        let creditsDetailsUrl = urlBuilder(endPoint: (Constants.peopleUrl + String(id)))
        guard let downloadCreditsDetailUrl = creditsDetailsUrl else { return }
        
        URLSession.shared.dataTask(with: downloadCreditsDetailUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let creditsDetails = try decoder.decode(CreditsDetailsServiceModel.self, from: data)
                completion(creditsDetails)
            } catch{}
        }.resume()
    }
    
    func getCreditsKnownFor(id: Int, completion: @escaping ([CreditsKnownForServiceModel]) -> Void) {
        let creditsKnownForUrl = urlBuilder(endPoint: (Constants.peopleUrl + String(id) + Constants.combinedCreditsUrl))
        guard let downloadCreditsKnownForUrl = creditsKnownForUrl else { return }
        
        URLSession.shared.dataTask(with: downloadCreditsKnownForUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let creditsKnownFor = try decoder.decode(CreditsKnownForModel.self, from: data)
                completion(creditsKnownFor.cast)
            } catch{}
        }.resume()
    }
    
    func getSearching(query: String, completion: @escaping ([SearchingServiceModel]) -> Void) {
        let searchingUrl = urlBuilderForSearching(endPoint: Constants.searchingUrl, queryNo: query.replacingOccurrences(of: " ", with: "%20"))
        guard let downloadSearchingUrl = searchingUrl else { return }
        
        URLSession.shared.dataTask(with: downloadSearchingUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let searching = try decoder.decode(SearchingModel.self, from: data)
                completion(searching.results)
            } catch{}
        }.resume()
    }
    
    func getToken(completion: @escaping (TokenResponseModel) -> Void) {
        let tokenUrl = urlBuilder(endPoint: Constants.tokenUrl)
        guard let getTokenUrl = tokenUrl else { return }
        
        URLSession.shared.dataTask(with: getTokenUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let tokens = try decoder.decode(TokenResponseModel.self, from: data)
                self.token = tokens.request_token
                completion(tokens)
            } catch {}
        }.resume()
    }
    
    func createSessionWithLogin( requestModel: LoginRequestModel?,
                                 completion: @escaping ([String: Any], (TokenResponseModel?)) -> Void) {
        
        let sessionUrl = urlBuilder(endPoint: Constants.createSessionWithLoginUrl)
        guard let getSessionIdUrl = sessionUrl else { return }
        var sessionRequest = URLRequest(url: getSessionIdUrl)
        sessionRequest.httpMethod = "POST"
        sessionRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sessionRequest.httpBody = try? JSONEncoder().encode(requestModel)

        
        URLSession.shared.dataTask(with: sessionRequest) { data, response, error in
            guard let data = data, error == nil, response != nil else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                do {
                    let decoder = JSONDecoder()
                    let jsonToken = try decoder.decode(TokenResponseModel.self, from: data)
                    completion(json,jsonToken)
                } catch {}
            } catch {}
        }.resume()
    }
    
    func createSessionID(requestModel: String?, completion: @escaping ([String: Any], (SessionIdResponseModel)) -> Void) {
                
        let sessionIdUrl = urlBuilder(endPoint: Constants.sessionUrl)
        guard let getSessionIdUrl = sessionIdUrl,
            let requestedToken = requestModel else { return }
        var requestToken: [String: String] = ["request_token": requestedToken]
        var sessionIdRequest = URLRequest(url: getSessionIdUrl)
        sessionIdRequest.httpMethod = "POST"
        sessionIdRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sessionIdRequest.httpBody = try? JSONEncoder().encode(requestToken)
//        sessionIdRequest.httpBody = try? JSONSerialization.data(withJSONObject: requestModel)
        
        URLSession.shared.dataTask(with: sessionIdRequest) { data, response, error in
            guard let data = data, error == nil, response != nil else { return }
            do {
                guard let jsonRequest = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                do {
                    let decoder = JSONDecoder()
                    let jsonResponse = try decoder.decode(SessionIdResponseModel.self, from: data)
                    completion(jsonRequest,jsonResponse)
                } catch {}
            } catch {}
        }.resume()
    }
    
    func getAccountDetails(requestModel: String?, completion: @escaping (AccountDetailsModel) -> Void) {
        
        let accountDetailsUrl = urlBuilderForAccounts(endPoint: Constants.accountUrl, sessionId: Constants.sessionIdUrl + (requestModel ?? ""))
        guard let getAccountDetailsUrl = accountDetailsUrl else { return }
        
        URLSession.shared.dataTask(with: getAccountDetailsUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let accountDetails = try decoder.decode(AccountDetailsModel.self, from: data)
                completion(accountDetails)
            } catch {}
        }.resume()
    }
    
    func markAsFavorite(sessionId: String?, accountId: String?, media_type: String?, media_id: Int?, favorite: Bool?, completion: @escaping ((FavoriteModel)) -> Void) {
        
        let parameters = ["media_type": media_type!, "media_id": media_id!, "favorite": favorite!] as [String : Any]
        
        let markAsFavoriteUrl = urlBuilderForAccounts(endPoint: (Constants.accountUrl + "/" + String(accountId ?? "") + Constants.favoriteUrl), sessionId: (Constants.sessionIdUrl + String(sessionId ?? "")))
        guard let getMarkAsFavoriteUrl = markAsFavoriteUrl else { return }
        var markAsFavoriteRequest = URLRequest(url: getMarkAsFavoriteUrl)
        markAsFavoriteRequest.httpMethod = "POST"
        markAsFavoriteRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        markAsFavoriteRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: markAsFavoriteRequest) {data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else { return }
            do {
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(FavoriteModel.self, from: data)
                completion(jsonResponse)
            } catch {}
        }.resume()
    }
    
    func favoriteMoviesList(accountId: String?, sessionId: String?, completion: @escaping ([MovieServiceModel]) -> Void) {
        
        let favoriteListUrl = urlBuilderForAccounts(endPoint: (Constants.accountUrl + "/" + (accountId ?? "") + Constants.favoriteUrl + Constants.moviesUrl), sessionId: (Constants.sessionIdUrl + (sessionId ?? "") + Constants.sortByUrl))
        guard let getFavoriteListUrl = favoriteListUrl else { return }
        URLSession.shared.dataTask(with: getFavoriteListUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let favoriteMovies = try decoder.decode(Movies.self, from: data)
                completion(favoriteMovies.results)
            } catch {}
        }.resume()
    }
    
    func favoriteSeriesList(accountId: String?, sessionId: String?, completion: @escaping ([SeriesServiceModel]) -> Void) {
        
        let favoriteListUrl = urlBuilderForAccounts(endPoint: (Constants.accountUrl + "/" + (accountId ?? "") + Constants.favoriteUrl + Constants.tvShowUrl), sessionId: (Constants.sessionIdUrl + (sessionId ?? "") + Constants.sortByUrl))
        guard let getFavoriteListUrl = favoriteListUrl else { return }
        URLSession.shared.dataTask(with: getFavoriteListUrl) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let favoriteSeries = try decoder.decode(SeriesModel.self, from: data)
                completion(favoriteSeries.results)
            } catch {}
        }.resume()
    }
    
    func getMovieAccountStates(accountId: String?, sessionId: String?, mediaId: Int?, completion: @escaping (AccountStatesModel) -> Void) {
        
        let accountStatesUrl = urlBuilderForAccounts(endPoint: (Constants.movieURL + String(mediaId ?? 0) + Constants.accountStatesUrl ), sessionId: (Constants.sessionIdUrl + String(sessionId ?? "")))
        guard let getAccountStatesUrl = accountStatesUrl else { return }
        URLSession.shared.dataTask(with: getAccountStatesUrl) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let accountStates = try decoder.decode(AccountStatesModel.self, from: data)
                completion(accountStates)
            } catch {}
        }.resume()
    }
    
    func getSeriesAccountStates(accountId: String?, sessionId: String?, mediaId: Int?, completion: @escaping (AccountStatesModel) -> Void) {
        
        let accountStatesUrl = urlBuilderForAccounts(endPoint: (Constants.seriesUrl + String(mediaId ?? 0) + Constants.accountStatesUrl ), sessionId: (Constants.sessionIdUrl + String(sessionId ?? "")))
        guard let getAccountStatesUrl = accountStatesUrl else { return }
        URLSession.shared.dataTask(with: getAccountStatesUrl) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let accountStates = try decoder.decode(AccountStatesModel.self, from: data)
                completion(accountStates)
            } catch {}
        }.resume()
    }
}
