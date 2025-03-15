//
//  Image+Resize.swift
//  Utils
//
//  Created by 김지현 on 3/15/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

extension Image {
    func withSize(_ size: CGFloat) -> Image {
        self.resizable()
            .interpolation(.high)
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(Rectangle())
    }
}
