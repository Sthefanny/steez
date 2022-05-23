//
//  HalfSheetController.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import SwiftUI

class HalfSheetController<Content>: UIHostingController<Content> where Content : View {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let presentation = sheetPresentationController {
            presentation.detents = [.medium(), .large()]
            presentation.prefersGrabberVisible = false
            presentation.largestUndimmedDetentIdentifier = .medium
            presentation.preferredCornerRadius = 30
        }
    }
}
