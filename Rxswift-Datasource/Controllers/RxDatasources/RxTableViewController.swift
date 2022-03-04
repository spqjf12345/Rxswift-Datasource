//
//  RxTableViewController.swift
//  Rxswift-Datasource
//
//  Created by JoSoJeong on 2022/03/04.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class RxTableViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    private var subject: BehaviorRelay<[SectionOfAnimal]> = BehaviorRelay(value: [])

    var viewModel = ViewModel(selected: Animal.EMPTY)
    var disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfAnimal>(
        configureCell: { datasource, tableview, indexPath, item in
            let cell = tableview.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            cell.configure(animal: item)
            return cell
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableview()
        bindViewModel()

    }
    
    func setUpTableview(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableview.rowHeight = 150
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
          return true
        }

        dataSource.canMoveRowAtIndexPath = { dataSource, indexPath in
          return true
        }
    }
    
    func bindViewModel(){
        viewModel.sectionAnimals
          .bind(to: tableview.rx.items(dataSource: dataSource))
          .disposed(by: disposeBag)
        
    }
    



}
