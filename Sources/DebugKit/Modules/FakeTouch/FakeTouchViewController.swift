//
//  FakeTouchViewController.swift
//  
//
//  Created by Владимир Беляев on 22.02.2022.
//

import UIKit

final class FakeTouchViewController: UIViewController {
  
  // MARK: - Properties
  private lazy var pointView: UIView = {
    let view: UIView = .init()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var finishButtom: UIButton = {
    let view: UIButton = .init(type: .system)
    view.backgroundColor = view.tintColor
    view.setTitleColor(.white, for: .normal)
    view.setTitle("Touch", for: .normal)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let closure: () -> Void
  
  init(_ closure: @escaping () -> Void) {
    self.closure = closure
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - VC Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black.withAlphaComponent(0.4)
    view.addSubview(pointView)
    view.addSubview(finishButtom)
    
    NSLayoutConstraint.activate([
      pointView.widthAnchor.constraint(equalToConstant: 8),
      pointView.heightAnchor.constraint(equalToConstant: 8),
      pointView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pointView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      finishButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      finishButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      finishButtom.heightAnchor.constraint(equalToConstant: 44),
      finishButtom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
    
    let swipeGesture: UIPanGestureRecognizer = .init(
      target: self,
      action: #selector(viewDidSwiped(gesture:)))
    view.addGestureRecognizer(swipeGesture)
    
    finishButtom.addTarget(
      self,
      action: #selector(finishButtonDidTapped),
      for: .touchUpInside)
  }
  
  // MARK: - Private methods
  @objc private func finishButtonDidTapped() {
    let point: CGPoint = pointView.center
    sendTouch(to: point)
  }
  
  @objc private func viewDidSwiped(gesture: UIPanGestureRecognizer) {
    if gesture.state == .changed || gesture.state == .ended {
      let multiplier: CGFloat = 0.2
      let translation: CGPoint = gesture.translation(in: self.view)
      pointView.center.x += translation.x * multiplier
      pointView.center.y += translation.y * multiplier
    }
  }
  
  private func sendTouch(to location: CGPoint) {
    self.closure()
    
    let keyWindow: UIWindow? = UIApplication.shared.keyWindow
    let view: UIView? = keyWindow?.hitTest(location, with: nil)
    
    self.handleTouch(for: view)
  }
  
  private func handleTouch(for view: UIView?) {
    let generator: UIImpactFeedbackGenerator = .init(style: .heavy)
    defer { generator.impactOccurred() }
    
    guard let unwrappedView = view else {
      return
    }
    
    if let _ = unwrappedView as? UIKeyInput {
      unwrappedView.becomeFirstResponder()
      return
    }
    
    if let control = unwrappedView as? UIControl {
      control.sendActions(for: .allTouchEvents)
      return
    }
    
    if let gestures = unwrappedView.gestureRecognizers,
       let tapGesture = gestures.first(where: { $0 is UITapGestureRecognizer }) {
      tapGesture.state = .ended
      return
    }
  }
}
