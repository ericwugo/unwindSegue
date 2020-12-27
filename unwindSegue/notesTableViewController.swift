//
//  notesTableViewController.swift
//  unwindSegue
//
//  Created by user on 2020/8/16.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
// 以下遵從 UIImagePickerControllerDelegate,UINavigationControllerDelegate主要是寫 imagePickerController 與 takePhoto action
class notesTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
 
    
    var notes = [Notes]()
    
    // 此為 tableView 中 cell 向左滑刪除資料的 func
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        Notes.saveToFile(notes: notes)
    }
    
    
    //以下為用 按下 done 的 unwind @IBAction 要先在此寫好，然後在 editNotesTableView 中的 done 按鈕拉取
    @IBAction func unwindTonotesTableView(segue: UIStoryboardSegue) {
        if let source = segue.source as? editNotesTableViewController,let note = source.notes {
            if let indexPath = tableView.indexPathForSelectedRow{
                notes[indexPath.row] = note
                tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }else {
                notes.insert(note, at: 0)
                let newIndexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // 用 struct Notes 的 saveToFile func 存擋
            Notes.saveToFile(notes: notes)
            
        }
        
        // Use data from the view controller which initiated the unwind segue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 在 viewDidLoad 中 開啟 app 時就讀取檔案的寫法 ！！！謹記啊 ！！！
        if let notes = Notes.readNotesFromFile(){
            self.notes = notes
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    //以下是 notesTableView 中 cell 對應的寫法 注意其 dequeueReusableCell 的屬性 ，還有 withIndentifier 的應用，要在  cell 中做相對應的 cell identifier 設定啊！
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)
        let note = notes[indexPath.row]
        // 以下 cell 的 textLabel 相關屬性寫法 對應上面 let note 抓取 var notes 的陣列 [Notes]() 的寫法非常重要 (在這夜程式碼的最上面) 要謹記啊 ！
        cell.textLabel?.text = "\(note.name)    \(note.type)    \(note.priority)"
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Marker Felt", size: 20)
        cell.contentView.backgroundColor = UIColor.brown
         

        return cell
    }
    

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
    
    // 以下 prepare 的寫法說明 此 destination 的 來源是 editNotesTableView ,並將其傳回的資料逐條呈現出來  當使用者點選某個 cell 選擇重覆的頻率時，將觸發 unwind segue，的 function prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? editNotesTableViewController, let row = tableView.indexPathForSelectedRow?.row {
            controller.notes = notes[row]
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        // 以下這行就是 delegate 的寫法
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // 以下是 imagePickerController 的func 把圖抓上來的寫法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
   
    
}
