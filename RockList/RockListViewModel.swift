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
    let group = DispatchGroup()
    let urlString = "\(url)"
    let urls = [ URL(string: urlString) ]
    let session = URLSession.shared
    for url in urls {
      group.enter()
      
      let task = session.dataTask(with: url!) { (data, response, error) in
        if let error = error {
          print("Error fetching data", error)
          group.leave()
          group.notify(queue: DispatchQueue.main, execute: {
            print("All Done");
          })
          return
        }
        if let safeData = data {
          self.parseJSON(safeData)
        }
      }
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(TrackModel.self, from: data)
      track = decodedData.results
//      decodedData.results.forEach({ song in
//        print("SONG", song)
//      })

    } catch {
      print(error)
    }
  }
  
  func millitoMinutes(data: Int) -> String {
    //    let milliseconds = currentTrack[currentSection].trackTimeMillis ?? 0
    let milliseconds = data
    let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1_000))

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "mm:ss"

//        print(formatter.string(from: date))
    return formatter.string(from: date)
  }
  
  func dateFormatter(convertDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let dateFromString: Date = dateFormatter.date(from: convertDate)!
    dateFormatter.dateFormat = "MMMM yyyy"
    let datenew = dateFormatter.string(from: dateFromString)
//      print("date: \(datenew)")
    return String(describing: datenew)
  }

}
