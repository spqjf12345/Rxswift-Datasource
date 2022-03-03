//
//  AnimalService.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/03.
//

import Foundation
import RxSwift
import RxCocoa

///https://zoo-animal-api.herokuapp.com/
class AnimalService {
    static var shared = AnimalService()
    
    func getRandomAnimal() -> Observable<Animal> {
        let url = URL(string: "https://zoo-animal-api.herokuapp.com/animals/rand")!
        return Observable.create{ emitter in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                guard let data = data, let animal = try? JSONDecoder().decode(Animal.self, from: data) else { emitter.onCompleted()
                    return
                }
                emitter.onNext(animal)
                emitter.onCompleted()
                
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    func getRandomAnimals(count: Int) -> Observable<[Animal]>{
        let url = URL(string: "https://zoo-animal-api.herokuapp.com/animals/rand/\(count)")!
        return Observable.create{ emitter in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                guard let data = data, let animal = try? JSONDecoder().decode([Animal].self, from: data) else { emitter.onCompleted()
                    return
                }
                emitter.onNext(animal)
                emitter.onCompleted()
                
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
