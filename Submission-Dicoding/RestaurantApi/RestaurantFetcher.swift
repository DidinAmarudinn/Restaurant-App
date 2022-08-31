//
//  RestaurantFetcher.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation
import Combine
protocol RestaurantFetchable {
    func getListRestaurant() -> AnyPublisher<ListRestauranResponse, RestaurantError>
    func getDetailRestaurant(withId id: String) -> AnyPublisher<DetailRestaurantResponse, RestaurantError>
}

class RestaurantFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
}

extension RestaurantFetcher: RestaurantFetchable {
    func getListRestaurant() -> AnyPublisher<ListRestauranResponse, RestaurantError> {
        return request(with: makeListRestaurantComponent())
    }
    
    func getDetailRestaurant(withId id: String) -> AnyPublisher<DetailRestaurantResponse, RestaurantError> {
        return request(with: makeDetailRestaurantComponent(withId: id))
    }
    
    private func request<T>(with component: URLComponents) -> AnyPublisher<T, RestaurantError> where T: Decodable {
        guard let url = component.url else {
            let error = RestaurantError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .mapError{ error in
                .network(description: error.localizedDescription)
            }
            .flatMap { val in
                decode(val.data)
            }
            .eraseToAnyPublisher()
        
    }
}

extension RestaurantFetcher {
    struct RestaurantAPI {
        static let scheme = "https"
        static let host = "restaurant-api.dicoding.dev"
        static let listEndpoint = "/list"
        static let detailEndpoint = "/detail/"
    }
    
    func makeListRestaurantComponent() -> URLComponents {
      var components = URLComponents()
      components.scheme = RestaurantAPI.scheme
      components.host = RestaurantAPI.host
      components.path = RestaurantAPI.listEndpoint
      return components
    }
    
    func makeDetailRestaurantComponent(withId id: String) -> URLComponents {
      var components = URLComponents()
      components.scheme = RestaurantAPI.scheme
      components.host = RestaurantAPI.host
      components.path = RestaurantAPI.detailEndpoint + id
      return components
    }
}


