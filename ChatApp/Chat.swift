//
//  Chat.swift
//  ChatApp
//
//  Created by kashee on 14/07/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import Foundation


class Chat {
    var userName:String?
    var description:String?
    var datePost:String?
    
    init(userName:String,description:String,datePost:String){
        self.userName = userName
        self.description = description
        self.datePost = datePost
    }
}
