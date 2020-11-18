//
//  CategoryCells.swift
//  GoldList
//
//  Created by Brian Gomes on 18/11/2020.
//

import UIKit

class CategoryCells: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var CategoryImage: UIImageView!
    
    @IBOutlet weak var CategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        bgView.layer.cornerRadius = 15
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        bgView.layer.shadowRadius = 5
        bgView.layer.shadowOpacity = 0.4
        bgView.layer.masksToBounds = false
    }

    
    func setData(Image:UIImage,Name:String){
        CategoryImage.image = Image
        CategoryName.text = Name
    }
    
}
