//
//  RxCollectionViewController.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/04.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import SDWebImage

class RxCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var subject: BehaviorRelay<[SectionOfAnimal]> = BehaviorRelay(value: [])

    var viewModel = ViewModel(selected: Animal.EMPTY)
    var disposeBag = DisposeBag()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfAnimal>(
        configureCell: { datasource, collectionview, indexPath, item in
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
            cell.configure(animal: item)
            return cell
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        bindViewModel()

    }
    
    func setUpCollectionView(){
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    
    }
    
    func bindViewModel(){
        viewModel.sectionAnimals
          .bind(to: collectionView.rx.items(dataSource: dataSource))
          .disposed(by: disposeBag)
        
    }
    



}

extension RxCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 3
        return CGSize(width: cellWidth, height: cellWidth/0.6)
    }
}

  
