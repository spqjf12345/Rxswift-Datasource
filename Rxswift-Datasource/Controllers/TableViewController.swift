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

///tableview using tableview.rx.item binding
class TableViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var viewModel = TableViewModel(selected: Animal.EMPTY)
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func bindViewModel(){
        viewModel.animals
            .filter{ !$0.isEmpty }
            .bind(to: tableview.rx.items(cellIdentifier: TableviewCell.identifier, cellType: TableviewCell.self)) { index, item, cell in
                cell.configure(animal: item)
            }.disposed(by: disposeBag)
    }
    
    


}

class TableviewCell: UITableViewCell {
    static var identifier = "TableviewCell"
    
    func configure(animal: Animal){
        
    }
}

