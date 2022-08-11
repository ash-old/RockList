//
//  ViewController.swift
//  RockList
//
//  Created by Ash Oldham on 02/08/2022.
//

import UIKit

class ViewController: UIViewController, RockListView {
  
  var viewModel: RockListViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    viewModel = RockListViewModel(view: self)
    setupViews()
  }
  
  private lazy var customNavBar: UINavigationBar = {
    let navBar = UINavigationBar()
    let title = UINavigationItem(title: "Rock List")
    navBar.setItems([title], animated: false)
    return navBar
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorColor = .darkGray
    tableView.separatorInset = .zero
    tableView.isScrollEnabled = true
    tableView.showsVerticalScrollIndicator = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(RockListViewCell.self, forCellReuseIdentifier: "RockListCell")
    return tableView
  }()
  
  private func setupViews() {
    [tableView, customNavBar].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
      customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      customNavBar.trailingAnchor.constraint(equalTo: view.leadingAnchor),
      customNavBar.heightAnchor.constraint(equalToConstant: 45),
      
      tableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
    ])
  }
  
  func update() {
    tableView.reloadData()
  }

}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.track?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RockListCell", for: indexPath) as? RockListViewCell, let vm = viewModel, let titlePrice = vm.track else { return UITableViewCell() }
    
    cell.icon.image = UIImage(named: titlePrice[indexPath.row].artworkUrl30)
    cell.trackNameLabel.text = vm.track?[indexPath.row].trackName
    cell.artistLabel.text = vm.track?[indexPath.row].artistName
    cell.priceLabel.text = String(describing: titlePrice[indexPath.row].trackPrice)
    
    return cell
  }
  
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return viewModel?.track?.count ?? 0
//  }
  
  
}

