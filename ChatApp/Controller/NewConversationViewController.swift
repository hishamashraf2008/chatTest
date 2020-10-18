//
//  NewConversationViewController.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/7/20.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    
    private let spinner = JGProgressHUD()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search for users .."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.isHidden = true
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "User not found"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSearchBar))
        searchBar.becomeFirstResponder() // allows the user to type once pressed the "compose" button to avoid double clicking
    }
    
    @objc private func dismissSearchBar(){
        dismiss(animated: true, completion: nil)
    }
}
extension NewConversationViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
