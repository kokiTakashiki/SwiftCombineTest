//
//  ViewController.swift
//  CombineGithubMyList
//
//  Created by 武田孝騎 on 2022/03/02.
//

import UIKit

protocol RepoListUserInterface: AnyObject {
    func updateRepoList(_ demoList: [RepoListEntity])
}

final class ViewController: UIViewController {
    
    // MARK: Type Aliases

    // MARK: Stored Instance Properties
    
    private var presenter: RepoListEventHandler!
    
    private var tableData: [RepoListEntity] = []

    // MARK: Computed Instance Properties

    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(.init(nibName: .RepoListViewCell, bundle: nil),
                               forCellReuseIdentifier: .RepoListViewCell)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await presenter.viewDidLoad()
            self.navigationItem.title = NSLocalizedString("title", comment: "")
        }
    }
    
    func inject(
        presenter: RepoListEventHandler
        //logger: LoggerProtocol = Logger.default
    ) {
        self.presenter = presenter
        //self.logger = logger
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .RepoListViewCell, for: indexPath) as? RepoListViewCell else {
            fatalError("Fail to load RepoListViewCell.")
        }
        
        Task {
            do {
                let data = tableData[indexPath.row]
                cell.setup(name: data.title)
            } catch {
                // TODO: エラーハンドリング
            }
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: RepoListUserInterface {
    func updateRepoList(_ repoList: [RepoListEntity]) {
        self.tableData = repoList
        tableView.reloadData()
    }
}
