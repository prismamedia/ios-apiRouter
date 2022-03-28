//
//  ViewController.swift
//  Api-Tools
//
//  Created by Joey BARBIER on 12/01/2021.
//

import UIKit
import ApiRouter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callData()
    }
    
    private func callData() {
        // Examples :

        // Automatic decoding
        ApiRouter.Todo.list.call { (result: Result<[Todo], Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let users):
                print("Todo List count : \(users.count) todo(s)")
            }
        }
        ApiRouter.Todo.get(id: "10").call { (result: Result<Todo?, Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let todo):
                print("Todo id = 10 - title : \(todo?.title ?? "NR")")
            }
        }
        
        // Custom handler result :
        ApiRouter.Todo.list.call { (result: Result<Data, Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                let result = String(data: data, encoding: .utf8) ?? ""
                print("Data : \(result)")
            }
        }
        
        // No handler (for example: pixel tracker ...) :
        ApiRouter.Todo.list.call { (result: Result<Void, Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success():
                print("success")
            }
        }
    }
}
