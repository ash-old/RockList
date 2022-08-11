//
//  RockListViewCell.swift
//  RockList
//
//  Created by Ash Oldham on 02/08/2022.
//

import UIKit

final class RockListViewCell: UITableViewCell {
  
  let icon: UIImageView = {
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
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.text = "track"
    return label
  }()
  
  let artistLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.text = "artist"
    return label
  }()
  
  let priceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.text = "£7.99"
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [trackNameLabel, artistLabel, priceLabel])
    stackView.axis = .vertical
    stackView.distribution = .fill
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    cellSetupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()

//      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }
  
  private func cellSetupLayout() {
    backgroundColor = .clear
    selectionStyle = .none
    
    [icon, stackView].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      icon.topAnchor.constraint(equalTo: contentView.topAnchor),
      icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      icon.heightAnchor.constraint(equalTo: contentView.heightAnchor),
      icon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
      
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
}
