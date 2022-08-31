//
//  DetailRestaurantView.swift
//  News-App
//
//  Created by didin amarudin on 30/08/22.
//

import SwiftUI

struct DetailRestaurantView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var viewModel: DetailRestaurantViewModel
    init(viewModel: DetailRestaurantViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        if let restaurantData = viewModel.dataSource {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        AsyncImage(url: URL(string: restaurantData.restaurant?.urlImage() ?? "")) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: geo.size.height * 0.7)
                                .edgesIgnoringSafeArea(.top)
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(.clear)
                    DescriptionView(height: geo.size.height * 0.6, restaurantData: restaurantData).description
                }
                
            } .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        BackButtonView(action: {dismiss()})
                    }
                }
            
        } else {
            ProgressView()
                .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct DetailRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailRestaurantViewModel(id: "0", restaurantFetcher: RestaurantFetcher())
        DetailRestaurantView(viewModel: viewModel)
    }
}
struct BackButtonView: View {
    let action: ()-> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .padding([.horizontal], 15)
                .padding([.vertical], 10)
                .foregroundColor(.black)
                .background(Color.white.opacity(0.5))
                .cornerRadius(8)
        }
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



struct DescriptionView {
    let height: CGFloat
    let restaurantData: DetailRestaurantResponse
    var description: some View {
        return VStack {
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(restaurantData.restaurant?.name ?? "")
                            .font(.system(.title))
                            .fontWeight(.bold)
                        .foregroundColor(.black)
                        Text("(\(restaurantData.restaurant?.getRating() ?? "0"))")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    if let categories = restaurantData.restaurant?.categories {
                        HStack {
                            ForEach(categories.indices, id: \.self) { index in
                                Text(categories[index].name ?? "")
                                    .font(.system(size: 10))
                                    .fontWeight(.light)
                                    .padding([.horizontal], 12)
                                    .padding([.vertical],8)
                                    .background(.gray.opacity(0.5))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    Text(restaurantData.restaurant?.restaurantDescription ?? "")
                        .font(.system(.caption))
                        .foregroundColor(.black.opacity(0.5))
                    Text("Food Menus")
                        .font(.system(.body))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    if let foods = restaurantData.restaurant?.menus?.foods {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(foods.indices, id: \.self) { index in
                                    Text(foods[index].name ?? "")
                                        .font(.system(size: 10))
                                        .fontWeight(.light)
                                        .padding([.horizontal], 12)
                                        .padding([.vertical],8)
                                        .background(.gray.opacity(0.2))
                                        .cornerRadius(4)
                                }
                            }
                        }
                    }
                    Text("Drinks Menus")
                        .font(.system(.body))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    if let drinks = restaurantData.restaurant?.menus?.drinks {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(drinks.indices, id: \.self) { index in
                                    Text(drinks[index].name ?? "")
                                        .font(.system(size: 10))
                                        .fontWeight(.light)
                                        .padding([.horizontal], 12)
                                        .padding([.vertical],8)
                                        .background(.gray.opacity(0.2))
                                        .cornerRadius(4)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
            }
            .padding(24)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: height)
            .background(.white)
            .cornerRadius(32, corners:[.topLeft,.topRight])
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.clear)
    }
}

struct ImageRestaurantView {
    let height: CGFloat
    var imageURL: String
    var image: some View {
        return VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: height)
                    .edgesIgnoringSafeArea(.top)
            } placeholder: {
                ProgressView()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.clear)
    }
}

