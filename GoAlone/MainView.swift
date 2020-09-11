//
//  MainView.swift
//  GoAlone
//
//  Created by HongYeol Jeon on 2020/09/04.
//  Copyright © 2020 HongYeol Jeon. All rights reserved.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to your world!")
                .font(.title)
                
                NavigationLink(destination: MapSearchView()) {
                    Text("Search location!")
                }.padding(.top, 60)
                
                NavigationLink(destination: MapView()) {
                    Text("My location")
                }.padding(.top, 60)
            }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
