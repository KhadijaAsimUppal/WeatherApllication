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
        bindVM()
    }
}

extension SearchTableViewCell {

    func bindVM() {
        vm.cityModel.bindAndTrigger({ [weak self] _ in
            self?.setUpUI()
        })
        
    }

    func setUpUI() {
        cityLabel.text = vm.cityString
        countryLabel.text = vm.countryString
    }
}
