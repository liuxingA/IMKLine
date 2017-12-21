//
//  IMKLineRightYView.swift
//  IMKLine
//
//  Created by 万涛 on 2017/12/19.
//  Copyright © 2017年 iMoon. All rights reserved.
//

import UIKit
import SnapKit

class IMKLineRightYView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func set(max: Double, min: Double, segment: Int, decimals: Int) {
        for subV in self.subviews {
            subV.removeFromSuperview()
        }
        let step = (max - min) / Double(segment - 1)
        
        for index in 0..<segment {
            let label = UILabel()
            label.textColor = IMKLineTheme.AccessoryTextColor
            label.font = UIFont.systemFont(ofSize: IMKLineTheme.AccessoryTextFontSize)
            label.text = String.init(format: "%.\(decimals)f", ((index == segment - 1) ? min : (max - step * Double(index))))
            label.adjustsFontSizeToFitWidth = true
            self.addSubview(label)
            label.snp.makeConstraints({ (maker) in
                maker.leading.equalToSuperview()
                maker.width.equalToSuperview()
                if index == 0 {
                    maker.top.equalToSuperview()
                } else if index == segment - 1 {
                    maker.bottom.equalToSuperview()
                } else {
                    maker.centerY.equalToSuperview().multipliedBy(CGFloat(index) * 2 / CGFloat(segment - 1))
                }
            })
        }
    }
    
//    var values = [Double]() {
//        didSet {
//            for subV in self.subviews {
//                subV.removeFromSuperview()
//            }
//            for index in 0..<values.count {
//                let label = UILabel()
//                label.textColor = IMKLineTheme.AccessoryTextColor
//                label.font = UIFont.systemFont(ofSize: IMKLineTheme.AccessoryTextFontSize)
//                label.text = "\(values[index])"
//                label.adjustsFontSizeToFitWidth = true
//                self.addSubview(label)
//                label.snp.makeConstraints({ (maker) in
//                    maker.leading.equalToSuperview()
//                    maker.width.equalToSuperview()
//                    if index == 0 {
//                        maker.top.equalToSuperview()
//                    } else if index == values.count - 1 {
//                        maker.bottom.equalToSuperview()
//                    } else {
//                        maker.centerY.equalToSuperview().multipliedBy(CGFloat(index) * 2 / CGFloat(values.count - 1))
//                    }
//                })
//            }
//        }
//    }
    
}
