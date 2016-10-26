//
//  InvertViewController.swift
//  HitAndMiss
//
//  Created by Yeom on 2016. 10. 7..
//  Copyright © 2016년 Yeom. All rights reserved.
//

import UIKit

class InvertViewController: UICollectionViewController {
    
    @IBOutlet var colNameList: UICollectionView!
    
    var nameArray = [String]()
    var missCount: Int?
    var missNumber = [Int]()
    var missIndex = Set<Int>()
    
    fileprivate let colors = [
        "0": UIColor(red: 239 / 255.0,    green: 108 / 255.0,     blue: 106 / 255.0,     alpha: 1.0),
        "1": UIColor(red: 214 / 255.0,    green: 152 / 255.0,     blue: 228 / 255.0,     alpha: 1.0),
        "2": UIColor(red: 242 / 255.0,    green: 167 / 255.0,     blue: 92  / 255.0,     alpha: 1.0),
        "3": UIColor(red: 229 / 255.0,    green: 201 / 255.0,     blue: 91  / 255.0,     alpha: 1.0),
        "4": UIColor(red: 35  / 255.0,    green: 123 / 255.0,     blue: 160 / 255.0,     alpha: 1.0),
        "5": UIColor(red: 112 / 255.0,    green: 193 / 255.0,     blue: 178 / 255.0,     alpha: 1.0),
        "6": UIColor(red: 114 / 255.0,    green: 189 / 255.0,     blue: 226 / 255.0,     alpha: 1.0),
        "7": UIColor(red: 160 / 255.0,    green: 178 / 255.0,     blue: 186 / 255.0,     alpha: 1.0),
        "8": UIColor(red: 175 / 255.0,    green: 187 / 255.0,     blue: 100 / 255.0,     alpha: 1.0),
        "9": UIColor(red: 143 / 255.0,    green: 226 / 255.0,     blue: 230 / 255.0,     alpha: 1.0)
    ]
    
    //fileprivate let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.colNameList!.register(MyCollectionCell.self, forCellWithReuseIdentifier: "MyCollectionCell.identifier")
        
        // Do any additional setup after loading the view.
        missNumber = Array(repeating: 0, count: nameArray.count)
        
        missIndex.removeAll()
        while missIndex.count != missCount {
            missIndex.insert(Int(arc4random_uniform(UInt32(missNumber.count))))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receive(item: Array<String>) {
        nameArray = item
    }
    
    func receive(count: Int) {
        missCount = count
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.nameArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionCell.identifier", for: indexPath) as! MyCollectionCell
        
        let name = self.nameArray[indexPath.item]
        let idx = indexPath.item % 10
        
        cell.colorView.layer.cornerRadius = 10.0
        cell.colorView.layer.masksToBounds = true
        cell.colorView.backgroundColor = self.colors["\(idx)"]
        
        cell.label.font = UIFont.systemFont(ofSize: 17.0)
        cell.label.textColor = UIColor.white
        cell.label.textAlignment = .center
        cell.label.text = name
    
        return cell
    }
    

    

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: MyCollectionCell = collectionView.cellForItem(at: indexPath) as! MyCollectionCell
        
        if missIndex.contains(indexPath.item) {
            cell.label.font = UIFont.systemFont(ofSize: 22.0)
            cell.label.text = "꽝!"
            cell.layer.borderWidth = 2.5
            cell.layer.cornerRadius = 10.0
            cell.layer.borderColor = UIColor.red.cgColor
        } else {
            cell.layer.borderWidth = 2.5
            cell.layer.cornerRadius = 10.0
            cell.layer.borderColor = UIColor.green.cgColor
        }
        
//        UIView.animate(withDuration: 1, delay: 0,
//                       options: [],
//                       animations: {cell.transform = __CGAffineTransformMake(0.9, 0.9, 0.9, 0.9, 0.9, 0.9)},
//                       completion: nil)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension InvertViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsInLine: CGFloat = 3.0
        
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        let minimumInteritemSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
        
        let itemWidth = (collectionView.frame.width - inset.left - inset.right - minimumInteritemSpacing * (numberOfItemsInLine - 1)) / numberOfItemsInLine
        let itemHeight = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 12.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 12.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}
