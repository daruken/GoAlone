//
//  ContentView.swift
//  GoAlone
//
//  Created by HongYeol Jeon on 2020/09/03.
//  Copyright © 2020 HongYeol Jeon. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State var isActive:Bool = false

    var body: some View {
        VStack {
            if self.isActive {
                MainView()
            } else {
                IntroView()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
