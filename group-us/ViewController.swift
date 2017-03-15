//
//  ViewController.swift
//  group-us
//
//  Created by SimpuMind on 3/9/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import PopupDialog

protocol UserInputCellDelegate: class {  // this is class protocol, to allow weak reference
    
    /// When text field is updated, cell calls this delegate method to inform it of changes
    /// to text field value.
    ///
    /// - Parameters:
    ///   - cell: Cell containing text field that was updated
    ///   - string: String value entered.
    
    func didUpdate(cell: UserInputCell, string: String?)
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numPerGroupTextField: UITextField!
    
    var isHandlingAddNewUser = false
    
    var datas = [String]()
    
    static var username = ""
    
    var deleteUserCell: IndexPath? = nil

    @IBAction func generateDetails(_ sender: Any) {
        
        let npgText = numPerGroupTextField.text
            
        if  let npG = Int(npgText!){
        
            if datas.count != 0 && npG <= datas.count{
                datas.shuffle()
                performSegue(withIdentifier: "UserD", sender: datas)
            }else{
                let title = "Group Us"
                let message = "Number of people per group is greater than number of names"
                
                presentAlert(title: title, message: message)
            }
        }else{
            let title = "Group Us"
            let message = "Number of people per group Text field cannot be nil"
            
            presentAlert(title: title, message: message)
        }
    }
    
    
    func presentAlert(title: String, message: String){
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: nil)
        
        // Create buttons
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }
        
        popup.addButtons([buttonOne])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    @IBAction func addNewName(_ sender: Any) {
        
        let indexPath = IndexPath(row: 0, section:0)
        datas.insert("", at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.titleView?.tintColor = .white
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "UserD"{
            
            if let names = sender as? [String]{
                let detailsVc = segue.destination as! UserDetailsViewController
                
                detailsVc.names = names
                detailsVc.pairBy = Int(numPerGroupTextField.text!)
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserInputCell
        cell.delegate = self
        cell.usernameTextField.text = datas[indexPath.row]
        return cell
    }
}

// MARK: - UserInputCellDelegate

extension ViewController: UserInputCellDelegate {
    
    func didUpdate(cell: UserInputCell, string: String?) {
        if let indexPath = tableView.indexPath(for: cell) {
            datas[indexPath.row] = string ?? ""             // update `datas` with value user edited
        }
        
        // For giggles and grins, let's print the array, so we can see what it's doing.
        // In production app, this `print` statement would be removed.
        
        print("\(datas)")
    }
    
}


extension Array {
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}
