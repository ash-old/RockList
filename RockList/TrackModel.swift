//
//  TrackDTO.swift
//  RockList
//
//  Created by Ash Oldham on 03/08/2022.
//

import UIKit

struct TrackModel: Codable {
  let results: [TrackData]
}

struct TrackData: Codable {
  let trackName: String
  let artistName: String
  let artworkUrl100: String
  let trackPrice: Double
  let trackTimeMillis: Int?
  let releaseDate: String?
  let trackViewUrl: String?
}
