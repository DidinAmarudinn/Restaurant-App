//
//  HomeScreen.swift
//  News-App
//
//  Created by didin amarudin on 25/08/22.
//

import SwiftUI

struct ListRestaurantView: View {
    @ObservedObject var viewModel: ListRestaurantViewModel
    init(viewModel: ListRestaurantViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        if viewModel.state == RequestState.loaded {
            content
        } else if viewModel.state == RequestState.loading {
            ProgressView()
        } else {
            Text("No Data")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
private extension ListRestaurantView {
    var content: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack (alignment: .leading){
                    ForEach(viewModel.listRestaurant.indices, id: \.self) { index in
                        ZStack(alignment: .leading){
                          
                            HStack {
                                AsyncImage(url: URL(string: viewModel.listRestaurant[index].urlImage())) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(24)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(viewModel.listRestaurant[index].name ?? "")
                                        .font(.system(.body))
                                    Text(viewModel.listRestaurant[index].restaurantDescription ?? "")
                                        .multilineTextAlignment(.leading)
                                        .font(.system(.caption))
                                        .lineSpacing(1.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                            .padding(8)
                            .background(.white)
                            .cornerRadius(24)
                            .padding([.bottom], 12)
                            
                            NavigationLink(destination: viewModel.goToDetailRestaurant(withId: viewModel.listRestaurant[index].id)) {
                                VStack{}
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                                    .padding(8)
                                    .background(.clear)
                                    .cornerRadius(24)
                                    .padding([.bottom], 12)
                            }
                           
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding([.trailing, .leading], 20)
            .background(Color(uiColor: UIColor(named: "background") ?? UIColor.white))
            .navigationBarTitle("Restaurant")
        }
    }
}

