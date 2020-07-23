//
//  Constants.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation
import UIKit

enum APIKey {
    static let key = "6b91316e7e7c0453ef4b1be090382d11"
}

enum NotificationNames {
    static let networkReachability = "networkReachability"
    static let weatherNotification = "weather-notification"
}

enum Identifiers {
    static let searchCellIdentifier = "searchCell"
    static let collectionViewCellIdentifier = "forecastCell"
    static let tableViewCellIdentifier = "forecastsCell"
    static let searchVCIdentifier = "searchVC"
    static let searchNavigationVCIdentifier = "searchNavigationVC"
    static let forecastMainVCIdentifier = "forecastMainVC"
}

enum StoryBoards {
    static let main : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
}

enum TextConstants {
    static let searchBarPlaceholderText = "Search City"
}

enum SearchState {
    case filtered, unfiltered
}

enum ViewMode {
    case live, offline

    mutating func toggle() {
        self = (self ==  .live) ? .offline : .live
    }
}
