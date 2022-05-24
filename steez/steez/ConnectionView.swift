//
//  ConnectionView.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import SwiftUI

struct ConnectionView: View {
    @State var showSplash = true
    
    var body: some View {
        ZStack {
            skateSlider()
            SplashScreen()
                .opacity(showSplash ? 1 : 0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation() {
                            self.showSplash = false
                        }
                    }
                }
        }
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
