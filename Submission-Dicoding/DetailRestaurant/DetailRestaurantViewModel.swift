//
//  DetailRestaurantViewModel.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation
import Combine
class DetailRestaurantViewModel: ObservableObject, Identifiable {
    @Published var dataSource: DetailRestaurantResponse?
    
    let id: String
    private let restaurantFetcher: RestaurantFetcher
    private var disposable = Set<AnyCancellable>()
    
    init(id: String, restaurantFetcher: RestaurantFetcher) {
        self.id = id
        self.restaurantFetcher = restaurantFetcher
        getDetail()
    }
    
    func getDetail() {
        restaurantFetcher.getDetailRestaurant(withId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = nil
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.dataSource = data
            })
            .store(in: &disposable)
    }
}
