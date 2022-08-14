//
//  RockTrackViewController.swift
//  RockList
//
//  Created by Ash Oldham on 14/08/2022.
//

import UIKit

class RockTrackViewController: UIViewController, RockListView {
  
  var viewModel: RockListViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    viewModel = RockListViewModel(view: self)
    setupViews()
  }
  
  let trackImage: UIImageView = {
    let icon = UIImageView()
    icon.contentMode = .scaleAspectFit
    icon.backgroundColor = .white
    return icon
  }()
  
  let trackNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.numberOfLines = 0
    label.text = "track"
    return label
  }()
  
  let artistLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.text = "artist"
    return label
  }()
  
  let priceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.text = "£7.99"
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [trackNameLabel, artistLabel, priceLabel])
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  let trackDurationLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
  }()
  
  let releaseDateLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
  }()
  
  private lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("More details", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .lightGray
    button.layer.cornerRadius = 4
    button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    button.layer.borderWidth = 1
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.shadowRadius = 2.0
    button.layer.shadowOpacity = 1.0
    button.layer.masksToBounds = false
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    return button
  }()
  
  @objc private func onButtonTap() {
    print("VIEW DETAILS")
  }
  
  func update() {
    //
  }
  
  private func setupViews() {
    [trackImage, stackView, trackDurationLabel, releaseDateLabel, button].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      trackImage.topAnchor.constraint(equalTo: view.topAnchor),
      trackImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      trackImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
      
      stackView.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      ])
  }
}
