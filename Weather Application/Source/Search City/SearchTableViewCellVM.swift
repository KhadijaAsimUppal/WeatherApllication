//
//  SearchTableViewCellVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 17/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class SearchTableViewCellVM {
    var cityModel: Bindable<CityModel?>?

    var cityString: String {
        return cityModel?.value?.name ?? " "
    }

    var countryString: String {
        return cityModel?.value?.country ?? " "
    }
}
