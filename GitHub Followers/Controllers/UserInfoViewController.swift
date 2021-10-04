//
//  UserInfoViewController.swift
//  GitHub Followers
//
//  Created by Admin on 8/9/21.
//

import UIKit

class UserInfoViewController: UIViewController {

    var username : String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews : [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfor(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func layoutUI() {
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for items in itemViews {
            view.addSubview(items)
            items.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                items.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                items.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        itemViewOne.backgroundColor = .systemBlue
        itemViewTwo.backgroundColor = .systemGreen
    
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
    }
    

}
