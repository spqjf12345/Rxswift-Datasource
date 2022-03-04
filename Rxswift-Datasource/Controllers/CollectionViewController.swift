//
//  CollectionViewController.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/04.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import SDWebImage

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = ViewModel(selected: Animal.EMPTY)
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setUpCollectionview()
       
    }
    
    private func setUpCollectionview(){
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        //delegate didselecteRowAt
        collectionView.rx.modelSelected(Animal.self)
            .subscribe(onNext: { animal in
                print(animal)
                //self.presentDetail()
            }).disposed(by: disposeBag)
            
    }
    
    private func bindViewModel(){
        //cellForRowAt
        viewModel.animals
            .filter{ !$0.isEmpty }
            .bind(to: collectionView.rx.items(cellIdentifier: CollectionViewCell.identifier, cellType: CollectionViewCell.self)) { index, item, cell in
                cell.configure(animal: item)
            }.disposed(by: disposeBag)
    }

   
}

class CollectionViewCell: UICollectionViewCell {
    static var identifier = "CollectionViewCell"
    
}
