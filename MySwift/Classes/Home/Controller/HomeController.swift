//
//  HomeController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import SVProgressHUD
import LLCycleScrollView


class HomeController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var exampleLab:UILabel!
    //var myTableView:UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = VIEW_BACK_COLOR;
        self.navigationItem.title = "首页"
        
        setUpTable()
        loadDataSource()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(dataArray)
        return dataArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)as! HomeCell
        //取消选中状态
        cell.selectionStyle = .none
        let model:HomeModel = dataArray .object(at: indexPath.row) as! HomeModel
        cell.cellForModel(model: model)
        cell.btnClickBlock = {()in
            print("点击了按钮，当前是第：\(indexPath.row)行 ，且事件传递到了控制器内");
        }
        return cell
        
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消选中样式
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailController()
        self.navigationController?.pushViewController(detail, animated: true)
        //self.navigationController ?.pushViewController(detail, animated: true)
        
    }
    
    func setUpTable(){
        view.addSubview(myTableView!)
        
        let headerBanner = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 170))
        //是否自动滚动
        headerBanner.autoScroll = true
        // 是否无限循环，此属性修改了就不存在轮播的意义了
        headerBanner.infiniteLoop = true
        // 滚动间隔时间(默认为2秒)
        headerBanner.autoScrollTimeInterval = 2.0
        // 等待数据状态显示的占位图
        headerBanner.placeHolderImage = UIImage(named: "startImg")
        // 如果没有数据的时候，使用的封面图
        headerBanner.coverImage = UIImage(named: "startImg")
        // 设置图片显示方式=UIImageView的ContentMode
        headerBanner.imageViewContentMode = .scaleToFill
        // 设置滚动方向（ vertical || horizontal ）
        headerBanner.scrollDirection = .horizontal
        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        headerBanner.customPageControlStyle = .snake
        // 非.system的状态下，设置PageControl的tintColor
        headerBanner.customPageControlInActiveTintColor = UIColor.red
        // 设置.system系统的UIPageControl当前显示的颜色
        headerBanner.pageControlCurrentPageColor = UIColor.white
        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        headerBanner.customPageControlIndicatorPadding = 8.0
        // 设置PageControl的位置 (.left, .right 默认为.center)
        headerBanner.pageControlPosition = .center
        // 背景色
        headerBanner.collectionViewBackgroundColor = UIColor.red
        
        // 添加到view
        myTableView?.tableHeaderView = headerBanner
        
        var arrayM = [String]()
        arrayM.append("https://img1.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1541231928.29.jpg")
        arrayM.append("https://img4.duitang.com/uploads/item/201210/06/20121006120433_CZXuC.jpeg")
        arrayM.append("http://www.pptok.com/wp-content/uploads/2012/08/xunguang-4.jpg")
        //let imageAer = ["https://img1.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1541231928.29.jpg","https://img4.duitang.com/uploads/item/201210/06/20121006120433_CZXuC.jpeg","http://www.pptok.com/wp-content/uploads/2012/08/xunguang-4.jpg"]
        
        headerBanner.imagePaths = arrayM
        
    }
    
    //MARK - 网络请求
    func loadDataSource(){
        SVProgressHUD .show()
        TTAlamoNetWorkTool.requestWith(Method: .get, URL: "https://api.douban.com/v2/movie/in_theaters", Parameter: nil, Token: nil) { (res) in
                
                let jsonStr = String(data: res.data!, encoding:String.Encoding.utf8)
                
                let dic = TTUtil.getDictionaryFromJSONString(jsonString: jsonStr!)
                
                let startInt = dic["start"] as? Int
                if(startInt==0){
                   let subArray = dic["subjects"] as! NSMutableArray
                    for dic in subArray{
                        //print(dic)
                        let model = HomeModel.deserialize(from: (dic as! [String : Any]))
                        //print(model?.title)
                        self.dataArray.add(model)
                    }
                    self.myTableView?.reloadData()
                    
                }
            SVProgressHUD .dismiss()
            
        }
    }
    //MARK - 懒加载
    lazy var dataArray:NSMutableArray = {
        
        //var dataArray = NSMutableArray.init(array: ["一","二","三","四","五"])
        var dataArray = NSMutableArray.init()
        return dataArray
    }()
    
    
    lazy var myTableView:UITableView? = {
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT-CGFloat(TabbarHeight)),style:.plain)
        //UITableViewCell.classForCoder()
        myTableView.register(HomeCell.classForCoder(), forCellReuseIdentifier: "identifier")
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.backgroundColor = VIEW_BACK_COLOR
        myTableView.separatorStyle = .singleLine
        return myTableView
    }()
}



