//
//  AboutPage.swift
//  News-App
//
//  Created by didin amarudin on 25/08/22.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 20){
            Spacer()
            VStack(alignment: .center, spacing: 12){
                Image("img_profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
                VStack(alignment:.leading) {
                    Text("Didin Amarudin")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Text("amardidin53@gmail.com")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .accentColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
           
            HStack {
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea(.all)
        .padding(20)
        .background(Color(uiColor: UIColor(named: "background") ?? UIColor.white))
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
