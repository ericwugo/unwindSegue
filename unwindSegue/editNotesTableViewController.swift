//
//  editNotesTableViewController.swift
//  unwindSegue
//
//  Created by user on 2020/8/16.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class editNotesTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var othersTextField: UITextField!
    // 以下以 var notes 設定為 struct Notes 型別的方式 謹記 ！
    var notes : Notes?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 當 使用者 按下 上一頁的 “新增” 時 讓 notes 等於 struct Notes 的屬性
        if let notes = notes{
            nameTextField.text = notes.name
            typeTextField.text = notes.type
            detailTextField.text = notes.details
            priorityTextField.text = notes.priority
            othersTextField.text = notes.others
        }
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // 當使用者按下 Done 時 prepare 執行 將所有欄位資料 傳回到 struct Notes 中並相互對應, 這樣的寫法 也要謹記啊 ！當使用者點選某個 cell 選擇重覆的頻率時，將觸發 unwind segue，此時將呼叫 function prepare，
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = nameTextField.text ?? ""
        let type = typeTextField.text ?? ""
        let details = detailTextField.text ?? ""
        let priority = priorityTextField.text ?? ""
        let others = othersTextField.text ?? ""
        
        
        if nameTextField.text?.isEmpty == true {
            let controller = UIAlertController(title: "主只要填寫啊", message: "您忘了輸入主旨", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller,animated: true,completion: nil)
        } else {
            notes = Notes(name: name, type: type, details: details, priority: priority, others: others)
        }
        
       // 把以上五個變數 逐一對應填入 struct Notes 中
        
    }
    
    
    
}
