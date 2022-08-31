//
//  ListRestaurantBuilder.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation
import SwiftUI
enum ListRestaurantBuilder {
  static func makeDetailRestaurant(
    withId id: String,
    restaurantFetcher: RestaurantFetcher
  ) -> some View {
    let viewModel = DetailRestaurantViewModel(
      id: id,
      restaurantFetcher: restaurantFetcher)
    return DetailRestaurantView(viewModel: viewModel)
  }
}
