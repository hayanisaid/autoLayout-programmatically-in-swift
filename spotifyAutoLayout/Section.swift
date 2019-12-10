//
//  Section.swift
//  spotifyAutoLayout
//
//  Created by admin on 12/6/19.
//  Copyright © 2019 Said Hayani. All rights reserved.
//

import Foundation
struct Section {
    var title : String
    var playlists : NSArray
    init(dictionary:[String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.playlists = dictionary["playlists"] as? NSArray ?? []
        
}
}
