//
//  IMKLineChartViewController.swift
//  IMKLine
//
//  Created by 万涛 on 2017/12/19.
//  Copyright © 2017年 iMoon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class IMKLineChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        (UIApplication.shared.delegate as! AppDelegate).interfaceOrientation = .landscape
    }
    
    @IBOutlet weak var klineContainerView: IMKLineContainerView!
    
    @IBAction func accessoryBtnClick() {
        self.klineContainerView.showAccessory = !self.klineContainerView.showAccessory
        self.klineContainerView.scrollView.klineView.draw()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getKlineDatas()
        self.klineContainerView.scrollView.loadMore = { [weak self] in
            self?.getKlineDatas()
        }
    }
    
    func getKlineDatas() {
//        let params = ["symbol":"btcusdt", "period":"1min","size":"60"]
//        Alamofire.request("https://api.huobi.pro/market/history/kline", parameters: params).responseData { [weak self] (response) in
//            let result = response.result
//            if result.isSuccess {
//                do {
//                    let jsonObj = try JSONSerialization.jsonObject(with: result.value!, options: .mutableLeaves)
//                    let json = JSON(jsonObj)
//                    if json["status"].stringValue == "ok" {
//                        self?.klineGroup = IMKLineGroup.init(datas: json)
//                        self?.showKline()
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }
        DispatchQueue.global().async {
            let dataJsonPath = Bundle.main.path(forResource: "data", ofType: "json")!
            let data = FileManager.default.contents(atPath: dataJsonPath)!
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let json = JSON(jsonObj)
                DispatchQueue.main.async(execute: {
                    let klineGroup = IMKLineGroup.init(datas: json)
                    if self.klineContainerView.scrollView.klineView.klineGroup.klineArray.count == 0 {
                        self.klineContainerView.scrollView.klineView.klineGroup = klineGroup
                    } else {
                        self.klineContainerView.scrollView.klineView.add(klineGroup: klineGroup)
                    }
                })
            } catch {
                print(error)
            }
        }
    }
    
    
    

    
    
    
    
    
    
    
    
    @IBAction func back() {
        (UIApplication.shared.delegate as! AppDelegate).interfaceOrientation = .portrait
        self.dismiss(animated: true, completion: nil)
    }
    
}
