//
//  MainView.swift
//  News-App
//
//  Created by didin amarudin on 25/08/22.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            ListRestaurantView(viewModel: ListRestaurantViewModel(restaurantFetcher: RestaurantFetcher()))
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(0)
               
            
            AboutScreen()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }.tag(1)
        }
        .accentColor(.black)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
