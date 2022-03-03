//
//  ViewController.swift
//  CombineGithubMyList
//
//  Created by 武田孝騎 on 2022/03/02.
//

import Combine
import UIKit

class ViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ReposListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.$reposData
            .sink { repo in
                print("call")
                if !repo.isEmpty {
                    print("Yes \(repo[0].name)")
                }
            }
            .store(in: &subscriptions)
    }


}

