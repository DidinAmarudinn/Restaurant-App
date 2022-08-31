//
//  ContentView.swift
//  Submission-Dicoding
//
//  Created by didin amarudin on 31/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MainView()
        }
        .background(.blue)
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
