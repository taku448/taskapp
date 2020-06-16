//
//  InputViewController.swift
//  taskapp
//
//  Created by 吉谷拓海 on 2020/06/15.
//  Copyright © 2020 takumi.yoshiya. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController {
    
    let realm = try! Realm()
    var task: Task!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var containsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date
        
    }
    override func viewWillDisappear(_ animated: Bool){
    try! realm.write{
        self.task.title = self.titleTextField.test!
        self.task.contents = self.contentsTextView.text
        self.task.date = self.datePicker.dateself.realm.add(self.task, update: .modified)
    }
        setNortification(task: task)
    super.viewWillDisappear(animated)
        
    }
    
    func setNortification(task: task){
        let content = UNMutableNotificationContent()
        if task.title == ""{
            content.title = "（タイトルなし）"
        }else{
            content.title - task.title
        }
        if task.cntents == ""{
            content.body = "（内容なし）"
        }else{
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeates: false)
        let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger:trigger)
        let center = UNNotificationCenter.current()
        center.add(request){ (error) in
            print(error ?? "ローカル通知登録　OK")
        }
        center.getPendingNotificationRequests{ (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/--------------")
                print(request)
                print("--------------/")
            }
            }
        }

    
    @obj func dismissKeyboard(){
        view.endEditing(true)
    }
    
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


