//
//  RockListViewModel.swift
//  RockList
//
//  Created by Ash Oldham on 02/08/2022.
//

import Foundation
import UIKit

protocol RockListView: UIViewController {
  func update()
}

class RockListViewModel {
  
  let url = "https://itunes.apple.com/search?term=rock"
  var view: RockListView?
  var track: [TrackData]?
  
  init(view: RockListView) {
    self.view = view
    
    getTrackData()
  }
  
  func getTrackData() {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"

    URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
      if let safeData = data {
        do {
            let jsonDecoder = JSONDecoder()
            let responseModel = try jsonDecoder.decode(TrackModel.self, from: safeData)
          self.track = responseModel.results
        } catch {
            print("JSON Serialization error")
        }
      }
        
    }).resume()
  }
  
  
  func millitoMinutes(data: Int) -> String {
    
    let milliseconds = data
    let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1_000))
    
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(identifier: "UTC")
    formatter.dateFormat = "mm:ss"
    
    return formatter.string(from: date)
  }
  
  func dateFormatter(convertDate: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let dateFromString: Date = dateFormatter.date(from: convertDate)!
    dateFormatter.dateFormat = "MMMM yyyy"
    let datenew = dateFormatter.string(from: dateFromString)
    
    return String(describing: datenew)
  }

}
