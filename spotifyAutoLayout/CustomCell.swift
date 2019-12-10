//
//  CustomCell.swift
//  spotifyAutoLayout
//
//  Created by admin on 10/31/19.
//  Copyright © 2019 Said Hayani. All rights reserved.
//


import UIKit

class CustomCell: UICollectionViewCell,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var section : Section? {
        didSet{
           
            guard let section = self.section else {return}
            self.titleLabel.text = section.title
          //  self.playlists = section.playlists
            self.section?.playlists.forEach({ (item) in
                let playlist = PlayList(dictionary: item as! [String : Any])
                self.playlists.append(playlist)

            })
            self.collectionView.reloadData()
            
        }
    }
   lazy var playlists = [PlayList]()
    let collectionView : UICollectionView = {
        // init the layout
        let layout = UICollectionViewFlowLayout()
        // set the direction to be horizontal
        layout.scrollDirection = .horizontal
        
        // the instance of collectionView
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       // cv.backgroundColor = .purple
       
        // get the collection view a  backgroundColor
         
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
        
    }()
    
    
    let cellId : String = "subCellID"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SubCustomCell
        // cell.backgroundColor = .yellow
        cell.playlist = playlists[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = frame.height / 2
        let height = frame.height / 2
        
        return CGSize(width: width, height: height)
        
    }
    let titleLabel: UILabel = {
        let lb  = UILabel()
        lb.text = "Section Title"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 8 ).isActive = true
        //titleLabel.bottomAnchor.constraint
        
    
       
       setupSubCells()
        collectionView.register(SubCustomCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
   
    
    fileprivate  func setupSubCells(){
        // add collectionView to the view
        addSubview(collectionView)
 
        collectionView.dataSource = self
        collectionView.delegate = self
        // setup constrainst
        // make it fit all the space of the CustomCell
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
