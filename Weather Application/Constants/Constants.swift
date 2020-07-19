//
//  Constants.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

enum APIKey {
    static let key = "6b91316e7e7c0453ef4b1be090382d11"
}

enum NotificationNames {
    static let networkReachability = "networkReachability"
    static let weatherNotification = "weather-notification"
}

enum Identifiers {
    static let searchCellIdentifier = "searchCell"
}

enum Text {
    static let searchBarPlaceholderText = "Search City"
}
//CR: All the type case should start with capital letters replace searchState with SearchState
enum searchState {
    case filtered, unfiltered
}
