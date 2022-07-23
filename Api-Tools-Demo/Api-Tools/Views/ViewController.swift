//
//  ViewController.swift
//  Api-Tools
//
//  Created by Joey BARBIER on 12/01/2021.
//

import UIKit
import OrkaApiRouter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callData()
        Task {
            await callDataAsync()
        }
    }
    
    private func callData() {
        // Examples :
        
        // Automatic decoding
        ApiRouter.Todo.list.call { (result: Result<[Todo], Error>) in
            switch result {
            case .failure(let error):
                print("call -> Todo ([R]) : \(error.localizedDescription)")
            case .success(let todo):
                print("Todo List count : \(todo.count) todo(s)")
            }
        }
        
        ApiRouter.Todo.get(id: "10").call { (result: Result<Todo?, Error>) in
            switch result {
            case .failure(let error):
                print("call -> Todo (R) : \(error.localizedDescription)")
            case .success(let todo):
                print("Todo id = 10 - title : \(todo?.title ?? "NR")")
            }
        }
        
        // Custom handler result :
        ApiRouter.Todo.list.call { (result: Result<Data, Error>) in
            switch result {
            case .failure(let error):
                print("call -> Data : \(error.localizedDescription)")
            case .success(let data):
                let result = String(data: data, encoding: .utf8) ?? ""
                print("Data : \(result)")
            }
        }
        
        // No handler (for example: pixel tracker ...) :
        ApiRouter.Todo.list.call { (result: Result<Void, Error>) in
            switch result {
            case .failure(let error):
                print("call -> Void : \(error.localizedDescription)")
            case .success():
                print("success")
            }
        }
    }
}

extension ViewController {
    private func callDataAsync() async {
        // Examples :
        
        // 1 - Automatic decoding
        // 1.1 - optionnal
        let todosAutoDecodingOptionnal: [Todo]? = try? await ApiRouter.Todo.list.call()
        print("[async] [optional] - optionnal Data : \(todosAutoDecodingOptionnal?.count ?? 0)")
        
        
        // 1.2 - with do / catch
        do {
            let todosAutoDecoding: [Todo] = try await ApiRouter.Todo.list.call()
            print("[async] - call -> [Todo] ([R]) \(todosAutoDecoding.count)")
        } catch (let error) {
            print("[async] call -> [Todo] ([R]) : \(error.localizedDescription)")
        }
        
        // 2 - Custom handler result :
        
        // 2.1 - optionnal
        if let dataOptionnal: Data = try? await ApiRouter.Todo.list.call() {
            let result = String(data: dataOptionnal, encoding: .utf8) ?? ""
            print("[async] [optional] call -> Data | \(result)")
        }
        
        
        // 2.1 - Try / Catch
        do {
            let data: Data = try await ApiRouter.Todo.list.call()
            let result = String(data: data, encoding: .utf8) ?? ""
            print("[async] call -> Data | \(result)")
        } catch (let error) {
            print("[async] call -> Data : \(error.localizedDescription)")
        }
        
        
        // No handler (for example: pixel tracker ...) :

        let callIsValidOptionnal: Void? = try? await ApiRouter.Todo.list.call()
        print("[async] [optional] callIsValid : \(callIsValidOptionnal != nil)")
        
        do {
            let _: Void = try await ApiRouter.Todo.list.call()
            print("[async] call -> void | callIsValid: true")
        } catch (let error) {
            print("[async] call -> void : \(error.localizedDescription)")
        }
    }
}
