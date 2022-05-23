//
//  PatternListView.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import SwiftUI

struct PatternListView: View {
    
    let screenSize = UIScreen.main.bounds.size
    @ObservedObject var bleManager: BLEManager
    @State private var patterns: [PatternModel]?
    
    var body: some View {
        ZStack {
            if patterns == nil {
                ProgressView()
            } else {
                List (patterns!) { pattern in
                    
                    blocoDeCor(bleManager: bleManager, selectedPattern: pattern.isActive, pattern: pattern, onEdit: {
                        patterns = UserData().getAllPatterns()
                    }, onDelete: {
                        UserData().deletePattern(id: pattern.id)
                        patterns = UserData().getAllPatterns()
                    })
                }
                .listStyle(.plain)
                .frame(width: screenSize.width, alignment: .center)
                .refreshable {
                    patterns = UserData().getAllPatterns()
                }
                
            }
        }.onAppear {
            patterns = UserData().getAllPatterns()
        }
        
    }
}

struct PatternListView_Previews: PreviewProvider {
    static var previews: some View {
        PatternListView(bleManager: BLEManager())
    }
}
