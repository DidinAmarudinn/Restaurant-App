//
//  Parsing.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation
import Combine
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, RestaurantError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
