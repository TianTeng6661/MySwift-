//
//  HomeCell.swift
//  MySwift
//
//  Created by yinhe on 2019/4/1.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UITableViewCell {
    
    public var btnClickBlock:( ()->() )?
    
    var showImage :UIImageView?
    var titleLab : UILabel?
    var detailLab : UILabel?
    //var actionBtn : UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        showImage = UIImageView.init(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        showImage?.backgroundColor = UIColor.green
        contentView.addSubview(showImage!)
        
        titleLab = UILabel.init(frame: CGRect(x: 45, y: 5, width: 100, height: 20))
        titleLab?.font = SystemFont(font: 15)
        titleLab?.textAlignment = NSTextAlignment.center
        titleLab?.textColor = UIColor.red
        contentView.addSubview(titleLab!)
        
        detailLab = UILabel.init(frame: CGRect(x: 45, y: 25, width: 100, height: 20))
        detailLab?.font = SystemFont(font: 15)
        detailLab?.textAlignment = NSTextAlignment.center
        detailLab?.textColor = UIColor.red
        contentView.addSubview(detailLab!)
        
        contentView.addSubview(actionBtn)
        
    }
    /*
     var title:String?
     var detail:String?
     var imgUrl:String?
     */
    func cellForModel(model:HomeModel?){
        if let tempModel = model{
            titleLab?.text = tempModel.title;
            detailLab?.text = tempModel.original_title;
            let imageStr = tempModel.images?["medium"]
            let imageUrl = URL(string: imageStr as! String)
        //SDWebImageLowPriority
            showImage?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "startImg"), options:.lowPriority , completed: nil)
            //let strUrl:String = tempModel.casts[0] as? String ?? ""
            /*
            do{
                let data = try Data(contentsOf: imageUrl!)
                showImage?.image = UIImage(data: data)
            }catch let error as NSError{
                print(error)
            }
            */
        }
    }
    
    //MARK - 按钮的点击事件
    @objc private func actionBtnClick(){
        btnClickBlock!()
    }
    
    lazy var actionBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.blue
        btn.frame = CGRect(x: SCREENWIDTH-60, y: 5, width: 40, height: 40)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("点击", for: .normal)
        btn.addTarget(self, action:#selector(actionBtnClick), for: .touchUpInside)
        return btn
        
        }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
