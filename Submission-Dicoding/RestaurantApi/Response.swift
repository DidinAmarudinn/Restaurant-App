//
//  Response.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import Foundation
struct ListRestauranResponse: Codable {
    var error: Bool?
    var message: String?
    var count: Int?
    var restaurants: [Restaurant]?
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var id: String
    var name, restaurantDescription, pictureID: String?
    var city: String?
    var rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case pictureID = "pictureId"
        case city, rating
    }
    func urlImage() -> String {
        let baseImgUrl = "https://restaurant-api.dicoding.dev/images/medium/"
        let imageId = pictureID ?? ""
        return baseImgUrl + imageId
    }
}

struct DetailRestaurantResponse: Codable {
    var error: Bool?
    var message: String?
    var restaurant: DetailRestaurant?
}

// MARK: - Restaurant
struct DetailRestaurant: Codable {
    var id, name, restaurantDescription, city: String?
    var address, pictureID: String?
    var rating: Double?
    var categories: [Category]?
    var menus: Menus?
    var customerReviews: [CustomerReview]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case city, address
        case pictureID = "pictureId"
        case rating, categories, menus, customerReviews
    }
    func urlImage() -> String {
        let baseImgUrl = "https://restaurant-api.dicoding.dev/images/large/"
        let imageId = pictureID ?? ""
        return baseImgUrl + imageId
    }
    func getRating() -> String {
        let rate = rating ?? 0.0
        return String(format: "%.1f", rate)
    }
}

// MARK: - Category
struct Category: Codable {
    var name: String?
}

// MARK: - CustomerReview
struct CustomerReview: Codable {
    var name, review, date: String?
}

// MARK: - Menus
struct Menus: Codable {
    var foods, drinks: [Category]?
}
