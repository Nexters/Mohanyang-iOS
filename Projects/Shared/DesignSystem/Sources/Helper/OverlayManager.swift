//
//  OverlayManager.swift
//  DesignSystem
//
//  Created by devMinseok on 4/2/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

class OverlayManager {
  static let shared = OverlayManager()
  private var hostingController: UIHostingController<AnyView>?

  private init() { }

  func showOverlay<V: View>(_ overlay: V) {
    guard let window = UIApplication.shared.connectedScenes
      .compactMap({ $0 as? UIWindowScene })
      .flatMap({ $0.windows })
      .first(where: { $0.isKeyWindow }) else {
      return
    }

    let anyOverlay = AnyView(overlay)

    if let existingController = hostingController {
      existingController.rootView = anyOverlay
    } else {
      hostingController = UIHostingController(rootView: anyOverlay)
      hostingController?.view.backgroundColor = .clear
      hostingController?.view.alpha = 0
    }

    guard let hostingController = hostingController else { return }
    hostingController.view.frame = window.bounds

    if hostingController.view.superview == nil {
      window.addSubview(hostingController.view)
    }
    window.bringSubviewToFront(hostingController.view)

    UIView.animate(withDuration: 0.3) {
      hostingController.view.alpha = 1
    }
  }

  func hideOverlay() {
    guard let hostingController = hostingController else { return }
    UIView.animate(
      withDuration: 0.3,
      animations: {
        hostingController.view.alpha = 0
      },
      completion: { _ in
        hostingController.view.removeFromSuperview()
        self.hostingController = nil
      }
    )
  }
}
