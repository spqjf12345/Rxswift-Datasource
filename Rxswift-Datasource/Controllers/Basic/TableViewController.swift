//
//  ViewController.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/02.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import SDWebImage

///tableview using tableview.rx.item binding
class TableViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var viewModel = ViewModel(selected: Animal.EMPTY)
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setUpTableview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setUpTableview(){
        tableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.identifier)
        tableview.rowHeight = 150
        
        //delegate didselecteRowAt
        tableview.rx.modelSelected(Animal.self)
            .subscribe(onNext: { animal in
                print(animal)
                //self.presentDetail()
            }).disposed(by: disposeBag)
            
    }
    
    private func bindViewModel(){
        //cellForRowAt
        viewModel.animals
            .filter{ !$0.isEmpty }
            .bind(to: tableview.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { index, item, cell in
                cell.configure(animal: item)
            }.disposed(by: disposeBag)
    }

}


class TableViewCell: UITableViewCell {
    static var identifier = "TableViewCell"
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var habitat: UIButton!
    
    func configure(animal: Animal){
        animalImage.sd_setImage(with: URL(string: animal.image_link))
        name.text = animal.name
        type.text = "Type : \(animal.animal_type)"
        habitat.setTitle(animal.habitat, for: .normal)
    }
}

