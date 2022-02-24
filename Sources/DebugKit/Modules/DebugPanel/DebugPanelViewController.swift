//
//  DebugPanelViewController.swift
//  
//
//  Created by Владимир Беляев on 22.02.2022.
//

import UIKit

final class DebugPanelViewController: UIViewController {
  
  // MARK: - Properties
  private lazy var tableView: UITableView = {
    let view: UITableView = .init()
    view.backgroundColor = .white
    return view
  }()
  
  private let closure: (DebugModule?) -> Void
  
  // MARK: - init/deinit
  init(_ closure: @escaping (DebugModule?) -> Void) {
    self.closure = closure
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - VC Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    
    navigationItem.title = "Modules"
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.indentifier)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.frame
  }
}

extension DebugPanelViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(
      withIdentifier: UITableViewCell.indentifier, for: indexPath)
    cell.textLabel?.text = DebugModule.init(rawValue: indexPath.row)?.description
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    closure(DebugModule.init(rawValue: indexPath.row))
  }
}
