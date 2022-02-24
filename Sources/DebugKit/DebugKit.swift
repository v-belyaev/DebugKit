//
//  DebugKit.swift
//
//
//  Created by Владимир Беляев on 22.02.2022.
//

import UIKit

public final class DebugKit {
  
  // MARK: - Properties
  private lazy var window: DebugWindow = .init()
  
  private lazy var rootController: StatusBarViewController = .init {
    self.openDebugPanel()
  }
  
  private lazy var keyWindow: UIWindow? = {
    return UIApplication.shared.keyWindow
  }()
  
  // MARK: - init/deinit
  public init() {
    self.checkCurrentThread()
    
    self.window.rootViewController = rootController
    self.window.isHidden = false
  }
  
  deinit { print("DebugKit deinit") }
}

// MARK: - Private methods
private extension DebugKit {
  func openDebugPanel() {
    UIView.animate(withDuration: 0.25) {
      self.window.size.toggle()
    } completion: { _ in
      let controller: DebugPanelViewController = .init { self.routeTo(to: $0) }
      let navigationController: UINavigationController = .init(rootViewController: controller)
      navigationController.modalPresentationStyle = .fullScreen
      self.rootController.present(navigationController, animated: true, completion: nil)
    }
  }
  
  func routeTo(to module: DebugModule?) {
    guard let module = module else {
      return
    }
    
    switch module {
    case .fakeTouch:
      window.rootViewController = FakeTouchViewController {
        self.restart()
      }
    }
  }
  
  func restart() {
    self.window.isHidden = true
    
    let window = DebugWindow()
    window.rootViewController = rootController
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.window = window
      self.window.isHidden = false
    }
  }
  
  func checkCurrentThread() {
    if !Thread.isMainThread {
      let message = "Make sure that \"DebugKit.init\" is always called from the main thread only."
      assertionFailure(message)
    }
  }
}
