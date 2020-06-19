//
//  ViewController.swift
//  taskapp
//
//  Created by 吉谷拓海 on 2020/06/14.
//  Copyright © 2020 takumi.yoshiya. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {

    
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
        var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        filterTextField.delegate = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: task.date)
        cell.detailTextLabel?.text = dateString
        cell.detailTextLabel?.text = task.category + " " + dateString
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = self.taskArray[indexPath.row]
            
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            
            try! realm.write {
            self.realm.delete(self.taskArray[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
                    }
        
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
            print("/---------")
            print(request)
            print("---------/")
            }
                        
            }
            }
        }
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        

        let predicate = NSPredicate(format: "category = %@" , filterTextField.text!)
        
        if filterTextField.text == "" {
            
            taskArray = realm.objects(Task.self).sorted(byKeyPath: "date")
            tableView.reloadData()
            
        }else {
              taskArray = realm.objects(Task.self).filter(predicate)
              tableView.reloadData()
        }
            self.view.endEditing(true)
        
        
     
      return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let inputViewController:InputViewController = segue.destination as! InputViewController

        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        } else {
            let task = Task()

            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
            }

            inputViewController.task = task
        }
    }


}
