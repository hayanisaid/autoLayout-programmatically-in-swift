//
//  ViewController.swift
//  spotifyAutoLayout
//
//  Created by admin on 10/31/19.
//  Copyright © 2019 Said Hayani. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId : String = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
        fetchJson()

    }
 
    var sections = [Section]()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = CGFloat(300)
       // var height : CGFloat = 1
       // height += view.frame.width
       // height += 50
        //height += 50
        //height += 20
        
        return CGSize(width: width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
         
        cell.section = sections[indexPath.item]
         
        return cell
    }
    func fetchJson (){
        print("attempt to fetch Json")
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [ Any] {
                            // do stuff
                    jsonResult.forEach { (item) in
                      
                        let section = Section(dictionary: item as! [String : Any])
                       // print("FEtching",section.playlists)
                        self.sections.append(section)
                    }
                    
                 
                  self.collectionView.reloadData()
                  }
              } catch {
                   // handle error
              }
        }
    }
}

