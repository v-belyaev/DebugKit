//
//  StatusBarViewController.swift
//  
//
//  Created by Владимир Беляев on 22.02.2022.
//

import UIKit

final class StatusBarViewController: UIViewController {
  
  private let onClick: () -> Void
  
  // MARK: - init/deinit
  init(onClick: @escaping () -> Void) {
    self.onClick = onClick
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - VC Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapGesture: UITapGestureRecognizer = .init(
      target: self, action: #selector(viewDidTapped))
    view.addGestureRecognizer(tapGesture)
    view.backgroundColor = .green
    view.alpha = 0.7
  }
  
  // MARK: - Private methods
  @objc private func viewDidTapped() {
    onClick()
  }
}
