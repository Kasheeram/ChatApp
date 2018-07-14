//
//  VCLogin.swift
//  ChatApp
//
//  Created by kashee on 14/07/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {

    
    var userNameText:UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Enter username"
        text.borderStyle = .roundedRect
        return text
    }()
    
    var loginButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(userNameText)
        view.addSubview(loginButton)
        
        userNameText.topAnchor.constraint(equalTo: view.topAnchor,constant:60).isActive = true
        userNameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        userNameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        userNameText.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: userNameText.bottomAnchor,constant:60).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func login(){
        let nextVC = ViewController()
        nextVC.userName = userNameText.text!
        self.present(nextVC, animated: true, completion: nil)
    }
}
