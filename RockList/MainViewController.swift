//
//  ViewController.swift
//  RockList
//
//  Created by Ash Oldham on 02/08/2022.
//

import UIKit

class MainViewController: UIViewController, RockListView {
  
  var viewModel: RockListViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    viewModel = RockListViewModel(view: self)
    setupViews()
  }
  
  private lazy var customNavBar: UIView = {
    let navBar = UIView()
    return navBar
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Rock Tracks"
    label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    return label
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorColor = .clear
    tableView.separatorInset = .zero
    tableView.isScrollEnabled = true
    tableView.showsVerticalScrollIndicator = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(RockListViewCell.self, forCellReuseIdentifier: "RockListCell")
    return tableView
  }()
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    NSLayoutConstraint.activate([
      customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
      customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      customNavBar.heightAnchor.constraint(equalToConstant: 40 + view.safeAreaInsets.top)
    ])
  }
  
  private func setupViews() {
    [tableView, customNavBar, titleLabel].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: customNavBar.centerYAnchor, constant: 42),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      tableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
    ])
  }
  
  func update() {
    tableView.reloadData()
  }

}

// MARK: TableView Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RockListCell", for: indexPath) as? RockListViewCell, let vm = viewModel, let titlePrice = vm.track else { return UITableViewCell() }
    
    vm.currentSection = indexPath.section
    
    if let url = URL(string: "\(titlePrice[indexPath.section].artworkUrl100)") {
      let data = try? Data(contentsOf: url)

      if let imageData = data {
        cell.icon.image = UIImage(data: imageData)
      }
    }
    
    cell.trackNameLabel.text = vm.track?[indexPath.section].trackName
    cell.artistLabel.text = vm.track?[indexPath.section].artistName
    cell.priceLabel.text = String(describing: "£ \(titlePrice[indexPath.section].trackPrice)")
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.track?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 4
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let rockTrackViewController = RockTrackViewController()
    rockTrackViewController.selectedIndex = indexPath.section
    present(rockTrackViewController, animated: true)
  }
  
  
}

