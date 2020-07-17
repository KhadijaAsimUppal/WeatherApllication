//
//  SearchTableViewCell.swift
//  Weather Application
//
//  Created by Khadija Asim on 17/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    var vm = SearchTableViewCellVM()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


}

extension SearchTableViewCell {

    func configureCell(_ model: CityModel?) {
        vm.cityModel = model
        setUpUI()
    }

    func setUpUI() {
        cityLabel.text = vm.cityString
        countryLabel.text = vm.countryString
    }
}
