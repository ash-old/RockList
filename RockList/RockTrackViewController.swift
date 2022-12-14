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
  private var moreDetail: Bool = false
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    view.backgroundColor = .lightGray
    setupViews()
  }
  
  private lazy var chevronButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.tintColor = .black
    button.addTarget(self, action: #selector(chevronTapped), for: .touchUpInside)
    return button
  }()
  
  private let trackImage: UIImageView = {
    let icon = UIImageView()
    icon.contentMode = .scaleAspectFit
    icon.backgroundColor = .lightGray
    return icon
  }()
  
  private let trackNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.numberOfLines = 0
    label.text = "track"
    return label
  }()
  
  private let artistLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.text = "artist"
    return label
  }()
  
  private let priceLabel: UILabel = {
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
  
  private let trackDurationLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.text = "duration"
    return label
  }()
  
  private let releaseDateLabel: UILabel = {
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
    view.backgroundColor = .white
    return view
  }()
  
  private lazy var webKitView: WKWebView = {
    let webView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration())
    webView.navigationDelegate = self
    webView.contentMode = .scaleAspectFit
    webView.layer.cornerRadius = 20
    webView.layer.masksToBounds = true
    return webView
  }()
  
  @objc private func onButtonTap() {
    moreDetail = true
    moreDetailSetup()
  }
  
  @objc private func chevronTapped(_ sender: Any) {
    if moreDetail {
      moreDetail = false
      moreDetailsView.removeFromSuperview()
      webKitView.removeFromSuperview()
    } else {
      self.dismiss(animated: true, completion: nil)
    }
    
  }
  
  private func openUrl() {
    guard let trackUrl = viewModel?.track?[selectedIndex].trackViewUrl else { return }
    
    if let url = URL(string: trackUrl), !url.absoluteString.isEmpty {
      let myRequest = URLRequest(url: url)
      webKitView.load(myRequest)
    }
  }
  
  private func setupViews() {
    [trackImage, chevronButton, stackView, trackDurationLabel, releaseDateLabel, button].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      chevronButton.topAnchor.constraint(equalTo: trackImage.topAnchor, constant: 16),
      chevronButton.leadingAnchor.constraint(equalTo: trackImage.leadingAnchor, constant: 16),
      chevronButton.heightAnchor.constraint(equalToConstant: 25),
      
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
      priceLabel.text = String(describing: "?? \(vm[selectedIndex].trackPrice)")
      trackDurationLabel.text = viewModel?.millitoMinutes(data: vm[selectedIndex].trackTimeMillis ?? 0)
      releaseDateLabel.text = viewModel?.dateFormatter(convertDate: vm[selectedIndex].releaseDate ?? "")
    } else {
      print("No data")
    }
    
  }
  
  private func moreDetailSetup() {
    [moreDetailsView, webKitView, chevronButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      moreDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
      moreDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      moreDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      moreDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      webKitView.topAnchor.constraint(equalTo: moreDetailsView.topAnchor, constant: 8),
      webKitView.leadingAnchor.constraint(equalTo: moreDetailsView.leadingAnchor, constant: 8),
      webKitView.trailingAnchor.constraint(equalTo: moreDetailsView.trailingAnchor, constant: -8),
      webKitView.bottomAnchor.constraint(equalTo: moreDetailsView.bottomAnchor)
    ])
    
    openUrl()
  }
}
