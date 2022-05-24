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
        skateSlider()
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
