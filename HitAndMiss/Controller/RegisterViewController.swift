//
//  RegisterViewController.swift
//  HitAndMiss
//
//  Created by Yeom on 2016. 10. 6..
//  Copyright © 2016년 Yeom. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var tblNameList: UITableView!
    
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.maximumValue = 0
        stepper.minimumValue = 0
        
        tblNameList.delegate = self
        tblNameList.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lblName.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableCell
        let borderColor = UIColor(red: 130.0/255.0, green: 145.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = borderColor.cgColor
        cell.layer.borderWidth = 0.5
        cell.cellLblName.text = nameArray[indexPath.row]
        cell.registerViewController = self;
        
        return cell
    }
    
    func deleteCell(_ cell: UITableViewCell) {
        if let deletionIndexPath = tblNameList.indexPath(for: cell) {
            nameArray.remove(at: deletionIndexPath.row)
            tblNameList.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
        
        if lblCount.text != "0" && Int(lblCount.text!) == Int(stepper.maximumValue) {
            lblCount.text = "\(Int(lblCount.text!)! - 1)"
        }
        stepper.maximumValue -= 1
        
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        lblCount.text = "\(Int(stepper.value))"
    }

    @IBAction func btnAdd(_ sender: UIButton) {
        if !(lblName.text?.isEmpty)! {
            nameArray.append(lblName.text!)
            lblName.text = ""
            stepper.maximumValue += 1
        }
        tblNameList.reloadData()
    }
    
    @IBAction func btnDeleteAll(_ sender: UIButton) {
        nameArray.removeAll()
        tblNameList.reloadData()
        lblCount.text = "0"
        stepper.maximumValue = 0
        stepper.minimumValue = 0
        lblName.text = ""
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgInvert" {
            let invertView = segue.destination as! InvertViewController
            invertView.receive(item: nameArray)
            invertView.receive(count: Int(lblCount.text!)!)
        }
    }
    

}
