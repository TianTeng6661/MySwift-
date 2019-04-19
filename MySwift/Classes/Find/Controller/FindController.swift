//
//  FindController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

let CollectionIden = "homeCell"

class FindController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let layout = UICollectionViewFlowLayout.init()
    weak var detailVC :ImageDetailController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.orange
        
        //设置布局
        setUpFlowLayout(flowLayout: layout)
        
        view.addSubview(myCollection!)
        
        loadData()
        
    }

    lazy var animation: HomeAnimation = {
        $0.presentDelegate = self as HomeAnimationPresentDelegate
        $0.dismissDelegate = self as HomeAnimationDismissDelegate
        return $0
    }(HomeAnimation())
    
    lazy var dataArray:NSMutableArray? = {
        var dataArray = NSMutableArray.init()
        return dataArray
    }()
    
    lazy var myCollection:UICollectionView? = {
        
        let myCollectionView = UICollectionView(frame: CGRect(x: 0, y: CGFloat(NaviHeight), width: SCREENWIDTH, height: SCREENHEIGHT-CGFloat(TabbarHeight)-CGFloat(NaviHeight)), collectionViewLayout:layout)
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: CollectionIden)
        return myCollectionView
        
    }()
    
}

//MARK:私有方法
extension FindController {
    
    
    func loadData(){
        
        //SVProgressHUD .show()
        /*
        let param = ["opt_type":1,
                     "size":50,
                     "offset":0]
        */
        TTAlamoNetWorkTool.requestWith(Method: .get, URL: "https://api.douban.com/v2/movie/in_theaters", Parameter: nil, Token: nil) { (res) in
            
            let jsonStr = String(data: res.data!, encoding:String.Encoding.utf8)
            
            let dic = TTUtil.getDictionaryFromJSONString(jsonString: jsonStr!)
            
            let startInt = dic["start"] as? Int
            if(startInt==0){
                let subArray = dic["subjects"] as! NSMutableArray
                for dic in subArray{
                    //print(dic)
                    let model = HomeModel.deserialize(from: (dic as! [String : Any]))
                    self.dataArray?.add(model)
                    //print(self.dataArray)
                }
                self.myCollection?.reloadData()
                
            }
            //SVProgressHUD .dismiss()
        }
    }
    
    func setUpFlowLayout(flowLayout: UICollectionViewFlowLayout){
        
        let itemCountInRow:CGFloat = 3
        let margin:CGFloat = 10
        let itemW = (SCREENWIDTH - (itemCountInRow+1)*margin) / itemCountInRow
        let itemH = itemW * 1.3
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        myCollection?.contentInset = UIEdgeInsets(top: margin,left: margin,bottom: margin,right: margin)
        layout.scrollDirection = .vertical
        
    }
}

//MARK:数据源
extension FindController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print((self.dataArray?.count)!)
        return (self.dataArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //负责创建cell
        let cell:ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionIden, for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    //即将显示某一个cell的时候
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //负责给cell赋值
        let myCell = cell as! ImageCollectionViewCell
        let model:HomeModel = dataArray?.object(at: indexPath.row) as! HomeModel
        myCell.cellForModel(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = ImageDetailController()
        self.detailVC = detail
        detail.models = self.dataArray as! [HomeModel]
        detail.scrollIndexPath = indexPath
        //过度动画
        //detail.modalTransitionStyle = .flipHorizontal
        //最终的展现样式
        detail.modalPresentationStyle = .custom
        
        detail.transitioningDelegate = animation
        
        present(detail, animated: true, completion: nil)
    }
    
    
}

extension FindController: HomeAnimationPresentDelegate{
    
    func presentAnimationView()->UIView{
        
        guard let currentIndexPath = myCollection?.indexPathsForSelectedItems?.first else {
            return UIView()
        }
        
        let imageView = UIImageView()
        
        let model = self.dataArray?.object(at: currentIndexPath.row) as!HomeModel
        let imageStr = model.images!["small"]
        //(model as AnyObject).images??["small"]
        
        if let imageUrl = URL(string: imageStr as! String){
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "startImg"), options:.lowPriority , completed: nil)
            return imageView
        }
        
        //let imageUrl = URL(string: imageStr as! String)
        //imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "startImg"), options:.lowPriority , completed: nil)
        
        return UIView();
        
    }
    func presentAnimationFromFrame()->CGRect{
        
        guard let currentIndexPath = myCollection?.indexPathsForSelectedItems?.first else {
            return CGRect.zero
        }
        guard let cell = myCollection?.cellForItem(at: currentIndexPath) else {
            return CGRect.zero
        }
        
        let window = UIApplication.shared.keyWindow
        let resultFrame = myCollection?.convert(cell.frame, to: window) ?? CGRect.zero
        
        return resultFrame
    }
    func presentAnimationToFrame()->CGRect{
        return SCREENBounds
    }
}


extension FindController: HomeAnimationDismissDelegate{
    
    func dismissAnimationView()->UIView{
        
        let imageView = UIImageView()
        
        let model = self.dataArray?.object(at: self.detailVC?.currentRow ?? 0) as!HomeModel
        let imageStr = model.images!["small"]
        //(model as AnyObject).images??["small"]
        
        if let imageUrl = URL(string: imageStr as! String){
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "startImg"), options:.lowPriority , completed: nil)
            return imageView
        }
        
        //let imageUrl = URL(string: imageStr as! String)
        //imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "startImg"), options:.lowPriority , completed: nil)
        
        return UIView();
    }
    func dismissAnimationFromFrame()->CGRect{
        return SCREENBounds
    }
    func dismissAnimationToFrame()->CGRect{
        
        let currentRow = self.detailVC?.currentRow ?? 0
        let currentIndexPath = IndexPath(row: currentRow, section: 0)
        
        guard let cell = myCollection?.cellForItem(at: currentIndexPath) else {
            
            var currentVisibleIndexPath = myCollection?.indexPathsForVisibleItems
            //这个数组并不是从小到大排列
            currentVisibleIndexPath?.sort { (first, second) -> Bool in
                return first.row < second.row
            }
            let minRow = currentVisibleIndexPath?.first?.row ?? 0
            //let maxRow = currentVisibleIndexPath?.last?.row ?? 0
            if currentRow < minRow{
                return CGRect.zero
            }else{
                return CGRect(x: SCREENWIDTH, y: SCREENHEIGHT, width: 0, height: 0)
            }
            
        }
        
        let window = UIApplication.shared.keyWindow
        let resultFrame = myCollection?.convert(cell.frame, to: window) ?? CGRect.zero
        
        return resultFrame
    }
    
}

