//
//  ListRestauranViewModel.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation
import Combine
import SwiftUI
enum RequestState {
    case loading
    case error
    case loaded
}
class ListRestaurantViewModel: ObservableObject, Identifiable {
    @Published var listRestaurant: [Restaurant] = []
    @Published var id: String = ""
    @Published var state: RequestState = RequestState.loading
    
    private let restaurantFetcher: RestaurantFetcher
    private var disposable = Set<AnyCancellable>()
    
    
    init(restaurantFetcher: RestaurantFetcher) {
        self.restaurantFetcher = restaurantFetcher
        getListRestaurant()
    }
    
    func getListRestaurant() {
        restaurantFetcher.getListRestaurant()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.listRestaurant = []
                    self.state = RequestState.error
                case .finished:
                    self.state = RequestState.loaded
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.listRestaurant = data.restaurants ?? []
            })
            .store(in: &disposable)
    }
}
extension ListRestaurantViewModel {
    func goToDetailRestaurant(withId restaurantId: String) -> some View {
          return ListRestaurantBuilder.makeDetailRestaurant(withId: restaurantId, restaurantFetcher: restaurantFetcher)
    }
}
