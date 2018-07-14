//
//  TVCChatCell.swift
//  ChatApp
//
//  Created by kashee on 14/07/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit

class TVCChatCell: UITableViewCell {

    var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "my name"
        return label
    }()
    
    var textView:UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.text = "my description"
        return txtView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(textView)
        
        nameLabel.topAnchor.constraint(equalTo:topAnchor,constant:2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant:2).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textView.topAnchor.constraint(equalTo:nameLabel.bottomAnchor,constant:2).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor,constant:2).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-2).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setChat(chat:Chat){
        nameLabel.text = chat.userName
        textView.text = chat.description
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
