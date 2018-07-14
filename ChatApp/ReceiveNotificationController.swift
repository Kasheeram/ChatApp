//
//  ReceiveNotificationController.swift
//  ChatApp
//
//  Created by kashee on 14/07/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit

class ReceiveNotificationController: UIViewController {

    var sendButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.functionName), name: NSNotification.Name(rawValue: "leave"), object: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(sendButton)
        
        sendButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:100).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:50).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        sendButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
    }
    
    
    @objc func sendMessage(){
        dismiss(animated: true, completion: nil)
        
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationID"), object: nil, userInfo: ["done":"i don't know"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    @objc func functionName(_ notification: NSNotification){
//        if let identify = notification.userInfo?["done"] as? String {
//
//            print(identify)
//
//        }
//    }
}
