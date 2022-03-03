//
//  TableViewModel.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/03.
//

import Foundation
import RxSwift

class TableViewModel {
    var animals = BehaviorSubject<[Animal]>(value: [])
    var selectedAnimals: Animal
    var disposeBag = DisposeBag()
    
    init(selected: Animal) {
        self.selectedAnimals = selected
        getAnimals()
    }
    
    func getAnimals(){
        AnimalService.shared.getRandomAnimals(count: 10)
            .take(1) // 한번만 호출
            .subscribe(onNext: { self.animals.onNext($0) })
            .disposed(by: disposeBag)
    }
    
}
