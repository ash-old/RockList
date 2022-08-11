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
    let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
//    let title = UINavigationItem(title: "Rock List")
//    navBar.topItem?.title = "Rock List"
//    navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font:UIFont(name:"HelveticaNeue", size: 26)!]
//    navBar.setItems([title], animated: false)
    navBar.topItem?.title = "YourTitle"
    return navBar
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
//    customNavBar.topItem?.title = "YourTitle"
  }
  
  private func setupViews() {
    [tableView, customNavBar].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RockListCell", for: indexPath) as? RockListViewCell, let vm = viewModel, let titlePrice = vm.track else { return UITableViewCell() }
    
    cell.icon.image = UIImage(named: titlePrice[indexPath.section].artworkUrl30)
    cell.trackNameLabel.text = vm.track?[indexPath.section].trackName
    cell.artistLabel.text = vm.track?[indexPath.section].artistName
    cell.priceLabel.text = String(describing: titlePrice[indexPath.section].trackPrice)
    
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
  
  
}

