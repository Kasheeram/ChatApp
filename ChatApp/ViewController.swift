//
//  ViewController.swift
//  ChatApp
//
//  Created by kashee on 11/07/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var userName:String?
    var ref = DatabaseReference()
    
    var chatText:UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "enter message"
        text.borderStyle = .roundedRect
        return text
    }()
    
    var sendButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView:UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TVCChatCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.nameOfFunction), name: NSNotification.Name(rawValue: "leave"), object: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        loginAnony()
        self.ref = Database.database().reference()
        
        view.addSubview(chatText)
        view.addSubview(sendButton)
        view.addSubview(tableView)
        
        chatText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        chatText.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:5).isActive = true
        chatText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        chatText.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        sendButton.bottomAnchor.constraint(equalTo: chatText.bottomAnchor).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: chatText.trailingAnchor,constant:2).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-2).isActive = true
        sendButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: chatText.topAnchor).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func nameOfFunction(notif: NSNotification) {
        if let value = notif.userInfo?["value"] as? [Chat] {

            print("Reseved notification value: \(value)")
        }
    }
    
    
    func loginAnony(){
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let error = error{
                print("Can not login")
            }else{
                print("User id: \(authResult?.user.uid)")
                //self.loadChatRoom()
            }
        }
    }
    
    
    var listOfChatInfo = [Chat]()
    func loadChatRoom(){
        self.ref.child("chat").queryOrdered(byChild: "postData").observe(.value, with:
            { (snapshot) in
                self.listOfChatInfo.removeAll()
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapshot{
                        if let postData = snap.value as? [String:Any]{
                            let username = postData["name"] as? String
                            let text = postData["text"] as? String
                            
                            var postDate:CLong?
                            if let postDateIn = postData["postData"] as? CLong{
                                postDate = postDateIn
                            }
                            
                            self.listOfChatInfo.append(Chat(userName: username!, description: text!, datePost: "\(postDate)"))
                        }
                    }
                    self.tableView.reloadData()
                    let indexpath = IndexPath(row: self.listOfChatInfo.count-1, section: 0)
                    self.tableView.scrollToRow(at: indexpath, at: .bottom, animated: true)
                }
            
        })
    }
    

    @objc func sendMessage(){
        let dic = ["text":chatText.text!,"name":userName!,"postData":ServerValue.timestamp()] as [String:Any]
        self.ref.child("chat").childByAutoId().setValue(dic)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TVCChatCell
        cell.setChat(chat: listOfChatInfo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

