//
//  RockTrackViewController.swift
//  RockList
//
//  Created by Ash Oldham on 14/08/2022.
//

import UIKit
import SafariServices
import WebKit

class RockTrackViewController: UIViewController, RockListView, WKNavigationDelegate {
  
  var viewModel: RockListViewModel?
  var selectedIndex: Int = 0
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    view.backgroundColor = .lightGray
    viewModel = RockListViewModel(view: self)
    setupViews()
  }
  
  private lazy var chevronImage: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.tintColor = .black
    button.addTarget(self, action: #selector(chevronTapped), for: .touchUpInside)
    return button
  }()
  
  let trackImage: UIImageView = {
    let icon = UIImageView()
    icon.contentMode = .scaleAspectFit
    icon.backgroundColor = .lightGray
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
    label.text = "price"
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
    label.text = "duration"
    return label
  }()
  
  let releaseDateLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.text = "release date"
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
  
  private let moreDetailsView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 30
    view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
    view.layer.masksToBounds = true
    view.backgroundColor = .white
    return view
  }()
  
  private lazy var webKitView: WKWebView = {
    let webView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration())
    webView.navigationDelegate = self
    webView.contentMode = .scaleAspectFit
    webView.layer.cornerRadius = 30
    webView.layer.masksToBounds = true
    return webView
  }()
  
  @objc private func onButtonTap() {
    print("VIEW DETAILS")
  }
  
  func update() {
    //
  }
  
  @objc private func chevronTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  private func setupViews() {
    [trackImage, chevronImage, stackView, trackDurationLabel, releaseDateLabel, button].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      chevronImage.topAnchor.constraint(equalTo: trackImage.topAnchor, constant: 16),
      chevronImage.leadingAnchor.constraint(equalTo: trackImage.leadingAnchor, constant: 16),
      chevronImage.heightAnchor.constraint(equalToConstant: 25),
      
      trackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
      trackImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      trackImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
      
      stackView.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      trackDurationLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
      trackDurationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      
      releaseDateLabel.topAnchor.constraint(equalTo: trackDurationLabel.bottomAnchor, constant: 4),
      releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      
      button.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 40),
      button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      button.heightAnchor.constraint(equalToConstant: 45)
      
      ])
    
    if let vm = viewModel?.track {
      if let url = URL(string: "\(vm[selectedIndex].artworkUrl100)") {
        let data = try? Data(contentsOf: url)

        if let imageData = data {
          trackImage.image = UIImage(data: imageData)
        }
      }
      trackNameLabel.text = vm[selectedIndex].trackName
      artistLabel.text = vm[selectedIndex].artistName
      priceLabel.text = String(describing: "£ \(vm[selectedIndex].trackPrice)")     
      trackDurationLabel.text = viewModel?.millitoMinutes(data: vm[selectedIndex].trackTimeMillis ?? 0)
      releaseDateLabel.text = viewModel?.dateFormatter(convertDate: vm[selectedIndex].releaseDate ?? "")
    }
  }
}
