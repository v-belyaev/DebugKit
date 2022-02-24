//
//  DebugWindow.swift
//  
//
//  Created by Владимир Беляев on 22.02.2022.
//

import UIKit

final class DebugWindow: UIWindow {
  
  // MARK: - Properties
  private let x: CGFloat = 16
  private let y: CGFloat = 88
  private let radius: CGFloat = 8
  private let screenFrame: CGRect = UIScreen.main.bounds
  
  var size: Size = .small {
    didSet {
      updateFrame()
      updateCornerRadius()
    }
  }
  
  // MARK: - init/deinit
  init() {
    super.init(frame: .init(origin: .init(x: x, y: y), size: size.rawValue))
    self.windowLevel = .normal + 1
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  private func updateFrame() {
    if size == .fullScreen {
      self.frame = screenFrame
      return
    }
    self.frame = .init(origin: .init(x: x, y: y), size: size.rawValue)
  }
  
  private func updateCornerRadius() {
    if size == .small {
      self.layer.cornerRadius = radius
      return
    }
    self.layer.cornerRadius = 0
  }
}

// MARK: - Position
extension DebugWindow {
  enum Size: RawRepresentable {
    init?(rawValue: CGSize) {
      return nil
    }
    
    case small
    case fullScreen
    
    var rawValue: CGSize {
      switch self {
      case .small:
        return .init(width: 16, height: 16)
      case .fullScreen:
        return UIScreen.main.bounds.size
      }
    }
    
    mutating func toggle() {
      if self == .small {
        self = .fullScreen
        return
      }
      self = .small
    }
  }
}
