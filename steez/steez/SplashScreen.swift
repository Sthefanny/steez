//
//  SplashScreen.swift
//  steez
//
//  Created by Lucas Yoshio Nakano on 23/05/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var maxWidth = UIScreen.main.bounds.width - 70
    @State var showSplash = true
    @State var scaleEffect = 0.5
    @State var position = CGPoint(x: 550, y: 0)
    @State var rotationAngle = Angle(degrees: 30)
    
    var body: some View {
        ZStack {
            Color.black
            Image("noise")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Image("steezRoundLogo")
                    .resizable()
                    .scaleEffect(scaleEffect)
                    .scaledToFill()
                    .padding(.bottom, 100)
                    .onAppear {
                        animationLogo()
                    }
                Image("steezSkate")
                    .resizable()
                    .rotationEffect(rotationAngle)
                    .position(position)
                    .scaledToFill()
                    .onAppear {
                        animationSkate1()
                        animationSkate2()
                    }
            }
            .frame(width: maxWidth, height: 0)
        }
    }
    
    private func animationLogo() {
        withAnimation(.easeInOut(duration: 2).delay(0.5)) {
            scaleEffect = 1.0
        }
    }
    
    private func animationSkate1() {
        withAnimation(.easeIn(duration: 1.5).delay(0.5)) {
            position = CGPoint(x: 170, y: 200)
        }
    }
    
    private func animationSkate2() {
        let deadline: DispatchTime = .now() + 2
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            rotationAngle = Angle(degrees: 10)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
