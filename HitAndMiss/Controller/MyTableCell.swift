//
//  MyTableCell.swift
//  HitAndMiss
//
//  Created by Yeom on 2016. 10. 6..
//  Copyright © 2016년 Yeom. All rights reserved.
//

import UIKit

class MyTableCell: UITableViewCell {
    @IBOutlet weak var cellLblName: UILabel!
//    @IBOutlet weak var cellBtnDelete: UIButton!
    
    var registerViewController: RegisterViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        //cellBtnDelete.addTarget(self, action: #selector(MyTableCell.deleteAction(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func cellBtnDelete(_ sender: UIButton) {
        registerViewController?.deleteCell(self)
    }
    
}
