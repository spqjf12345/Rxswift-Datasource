//
//  Book.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/03.
//

import Foundation
import RxDataSources

struct Animal: Codable {
    var name: String
    var latin_name: String
    var animal_type: String
    var active_time: String
    var length_min: String
    var length_max: String
    var weight_min: String
    var weight_max: String
    var lifespan: String
    var habitat: String
    var diet: String
    var geo_range: String
    var image_link: String
    var id: Int
}

extension Animal {
    static let EMPTY = Animal(name: "", latin_name: "", animal_type: "", active_time: "", length_min: "", length_max: "", weight_min: "", weight_max: "", lifespan: "", habitat: "", diet: "", geo_range: "", image_link: "", id: 0)
}

struct SectionOfAnimal {
    var header: String
    var items: [Item]
}

extension SectionOfAnimal {
    static let EMPTY = SectionOfAnimal(header: "", items: [Animal.EMPTY])
}


extension SectionOfAnimal: SectionModelType {
    typealias Item = Animal
    init(original: SectionOfAnimal, items: [Item]){
        self = original
        self.items = items
    }
}
