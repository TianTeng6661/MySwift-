//
//  ImageDetailController.swift
//  MySwift
//
//  Created by yinhe on 2019/4/17.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

let DetailIden = "detailCell"

class ImageDetailController: BaseViewController {

    var models:[HomeModel] = []
    var scrollIndexPath: IndexPath?
    let layout = UICollectionViewFlowLayout.init()
    
    var currentRow: Int {
        let row = myCollection?.indexPathsForVisibleItems.first?.row ?? 0
        return row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        //设置布局
        setUpFlowLayout(flowLayout: layout)
        
        view.addSubview(myCollection!)
        
        view.addSubview(actionBtn)
        
        if let indexPath = scrollIndexPath{
            myCollection?.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        
        
    }
    
    //MARK - 按钮的点击事件
    @objc private func actionBtnClick(){
        dismiss(animated: true, completion: nil)
    }
    
    lazy var actionBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.blue
        btn.frame = CGRect(x: 20, y: SCREENHEIGHT-60, width: 60, height: 40)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("关闭", for: .normal)
        btn.addTarget(self, action:#selector(actionBtnClick), for: .touchUpInside)
        return btn
        
    }()
    
    lazy var myCollection:UICollectionView? = {
        
        let myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT-CGFloat(BottomHeight)), collectionViewLayout:layout)
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.isPagingEnabled = true
        myCollectionView.register(ImageDetailCell.self, forCellWithReuseIdentifier: DetailIden)
        return myCollectionView
        
    }()

}

//MARK: -- 私有方法
extension ImageDetailController {
    
    func setUpFlowLayout(flowLayout: UICollectionViewFlowLayout){
        
        let margin:CGFloat = 0
        /*
        let itemCountInRow:CGFloat = 3
        let margin:CGFloat = 10
        let itemW = (SCREENWIDTH - (itemCountInRow+1)*margin) / itemCountInRow
        let itemH = itemW * 1.3
        */
        layout.itemSize = CGSize(width:SCREENWIDTH, height: SCREENHEIGHT)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        myCollection?.contentInset = UIEdgeInsets(top: margin,left: margin,bottom: margin,right: margin)
        layout.scrollDirection = .horizontal
        
    }
    
}

//MARK: -- delegate
extension ImageDetailController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //负责创建cell
        let cell:ImageDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIden, for: indexPath) as! ImageDetailCell
        cell.backgroundColor = UIColor.white
        let model:HomeModel = models[indexPath.row]
        cell.cellForModel(model: model)
        return cell
    }
    
}

