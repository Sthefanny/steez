//
//  HomeView.swift
//  steez
//
//  Created by Jessica Akemi Meguro on 20/05/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                HStack (alignment: .center) {
                    //Logo and camera
                    Image("steezLogo")
                        .resizable()
                        .frame(width: 112, height: 29, alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36, alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.bottom, 36)
                
                ZStack {
                    Image("skate")
                        .resizable()
                        .frame(width: 280, height: 250)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 36)
                
                HStack (spacing: 18) {
                    button1(title: "ALTURA", showBackgroundColor: false, changeColorTitle: false)
                    
                    button1(title: "IMPULSO", showBackgroundColor: true, changeColorTitle: true)
                    
                    button1(title: "ROTAÇÃO", showBackgroundColor: false, changeColorTitle: false)
                }
                .padding(.bottom, 36)
                
                    VStack(alignment: .center){
                        blocoDeCor(selectedPattern: true)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
