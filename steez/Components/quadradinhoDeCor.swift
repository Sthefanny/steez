//
//  quadradinhoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 20/05/22.
//

import Foundation
import SwiftUI

struct quadradinhoDeCor: View {
    @State var isCliked = false
    @State var color = UIColor.red
    var body: some View {

    RoundedRectangle(cornerRadius: 5)
            .stroke(isCliked ? Color.white : Color(color as! CGColor), lineWidth: 5)
    .background(Color(color))
    .frame(width: 55, height: 40, alignment: .center)
    .padding(.trailing, -6.0)
    .onTapGesture {
    isCliked = !isCliked
    }
       
    }
}

        struct quadradinhoDeCor_Previews: PreviewProvider {
            static var previews: some View {
                quadradinhoDeCor()
            }
        }
