//
//  CategoryData.swift
//  GoldList
//
//  Created by Brian Gomes on 18/11/2020.
//

import UIKit

class categoryData: NSObject {
    let catImg:UIImage
    let catName:String
    let catID:String
    
    init(catImg:UIImage?, catName:String?,catID:String?)
    {
        self.catImg = catImg!
        self.catName = catName!
        self.catID = catID!
    }
}
