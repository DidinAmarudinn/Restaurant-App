//
//  RestaruantError.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation

enum RestaurantError: Error {
  case parsing(description: String)
  case network(description: String)
}
