//
//  IntroView.swift
//  GoAlone
//
//  Created by HongYeol Jeon on 2020/09/04.
//  Copyright © 2020 HongYeol Jeon. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            Color.init(red: 30/255, green: 255/255, blue: 204/255, opacity: 1).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("GoAlone")
                    .font(.custom("title", size: 70))
                    .foregroundColor(.white)
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
