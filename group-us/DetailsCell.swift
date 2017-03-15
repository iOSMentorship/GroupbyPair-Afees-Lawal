//
//  DetailsCell.swift
//  group-us
//
//  Created by SimpuMind on 3/10/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var groupCountLabel: UILabel!
    
    var names: [String]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as! UserCollectionViewCell
        
        cell.name = names?[indexPath.item]
        
        if indexPath.item % 2 == 0{
            cell.userProfileImageView.image = UIImage(named: "man2")
        }else{
            cell.userProfileImageView.image = UIImage(named: "man1")
        }
        
        return cell
    }
    
}
