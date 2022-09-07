//
//  Router.swift
//  ViperFinalWork
//
//  Created by emre usul on 25.04.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    
    static let apiKey = "c928e02d6dfb0146a55c6dfcd8d06085"
    
    case movieUpcoming
    case moviePlaying
    case movieDetail(movieId:Int)
    case movieSimilar(similarId:Int)
    case movieSearch(searchText: String)
   
    
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var method: HTTPMethod {
        switch self {
        case  .movieUpcoming, .moviePlaying, .movieDetail,.movieSimilar, .movieSearch:
            return .get
        }
    }
    
    var parameters: [String:Any]? {
        var params: Parameters = [:]
        switch self {
        case .movieSimilar:
            return nil
        case .movieUpcoming:
            return nil
        case .moviePlaying:
            return nil
        case .movieDetail:
           return nil
        case .movieSimilar:
            return nil
        case .movieSearch(let text):
            return ["query": text]
        }
        
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path:String {
        switch self {
        case .movieUpcoming:
            return "/movie/upcoming"
        case .moviePlaying:
            return "/movie/now_playing"
        case .movieDetail(movieId: let movieID):
            return "/movie/\(movieID)"
        case .movieSimilar(similarId: let similarId):
            return "/movie/\(similarId)/similar"
        case .movieSearch:
            return "/search/movie"
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding : ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
      
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("********* -> MY URL ",urlRequestPrint.url ?? "")
        return try encoding.encode(urlRequest, with:completeParameters)
    
    }
}


