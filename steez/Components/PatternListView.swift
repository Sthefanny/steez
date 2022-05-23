//
//  PatternListView.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import SwiftUI

struct PatternListView: View {
    @State private var patterns: [PatternModel]?
    
    var body: some View {
        List{
            if patterns == nil {
                ProgressView()
            } else {
                ForEach (0..<patterns!.count) { i in
                    var pattern = patterns![i]
                    blocoDeCor(selectedPattern: pattern.isActive, pattern: pattern)
                }
            }
            
        }
        .listStyle(.plain)
        .onAppear {
            patterns = UserData().getAllPatterns()
            print(patterns)
        }
    }
}

struct PatternListView_Previews: PreviewProvider {
    static var previews: some View {
        PatternListView()
    }
}
