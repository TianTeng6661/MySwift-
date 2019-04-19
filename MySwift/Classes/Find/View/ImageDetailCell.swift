//
//  ImageDetailCell.swift
//  MySwift
//
//  Created by yinhe on 2019/4/17.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

class ImageDetailCell: UICollectionViewCell {
    
    
    var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        /*
        let itemCountInRow:CGFloat = 3
        let margin:CGFloat = 10
        let itemW = (SCREENWIDTH - (itemCountInRow+1)*margin) / itemCountInRow
        let itemH = itemW * 1.3
        */
        imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        imageView?.backgroundColor = UIColor.green
        contentView.addSubview(imageView!)
    }
    
    func cellForModel(model:HomeModel?){
        
        let imageStr = model?.images?["small"]
        let imageUrl = URL(string: imageStr as! String)
        imageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "startImg"), options:.lowPriority , completed: nil)
    }
    
}
