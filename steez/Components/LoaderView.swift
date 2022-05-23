//
//  LoaderView.swift
//  steez
//
//  Created by Lucas Yoshio Nakano on 23/05/22.
//

import SwiftUI

struct LoaderView: View {
    var progressViewColor: Color = .white
    var progressViewScaleSize: CGFloat = 1.0
    var title: String?
    var titleColor: Color = .white
    var titleSize: CGFloat = 20.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            ZStack {
                Rectangle()
                    .foregroundColor(Color("cinzaescuro"))
                    .frame(width: 250, height: 250, alignment: .center)
                    .cornerRadius(40)
                VStack {
                    ProgressView()
                        .scaleEffect(progressViewScaleSize, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: progressViewColor))
                        .padding(.bottom, 30)
                    Text(title ?? "")
                        .font(.system(size: titleSize))
                        .foregroundColor(titleColor)
                }
            }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(progressViewColor: .red, progressViewScaleSize: 3.0, title: "Conectando Dispositivo", titleColor: .red)
    }
}
