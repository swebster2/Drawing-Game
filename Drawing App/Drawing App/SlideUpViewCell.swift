//
//  SlideUpViewCell.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import Foundation
import UIKit

class SlideUpViewCell: UITableViewCell {
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    lazy var iconView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
        return view
    }()
    lazy var labelView: UILabel = {
        let view = UILabel(frame: CGRect(x: 60, y: 10, width: self.frame.width - 75, height: 30))
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(iconView)
        backView.addSubview(labelView)
    }
}
