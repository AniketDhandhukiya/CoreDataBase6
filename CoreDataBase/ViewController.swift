//
//  ViewController.swift
//  CoreDataBase
//
//  Created by R83 on 24/04/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var idTextFiled: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addButton(_ sender: UIButton) {
        if let x = idTextFiled.text,let y = Int(x) {
            addData(id: y ,name: nameTextFiled.text ?? "")
        }
    }
    
    
    @IBAction func getDataButton(_ sender: UIButton) {
        getdata()
    }
    
    @IBAction func deleteDataButton(_ sender: UIButton) {
        if let x = idTextFiled.text,let y = Int(x) {
            deletedata(id: y)
        }
    }
    
    func addData(id : Int,name : String){
        
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manegeContex = appDeleget.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Student", in: manegeContex)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: manegeContex)
        user.setValue(name, forKey: "name")
        user.setValue(id, forKey: "id")
        print(user)
        appDeleget.saveContext()
    }
    
    func getdata(){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manegeContex = appDeleget.persistentContainer.viewContext
        let fetchRqust = Student.fetchRequest()
        
        do {
            let result = try manegeContex.fetch(fetchRqust)
            for data in result {
                print(data.name as! String,data.id)
            }
            print("Data Get")
        }
        catch {
            print("Could not save.")
        }
    }
    
    func deletedata(id : Int){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manegeContex = appDeleget.persistentContainer.viewContext
        let fetchRqust = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        fetchRqust.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            let test = try manegeContex.fetch(fetchRqust)
            let obj = test[0] as! NSManagedObject
            manegeContex.delete(obj)
            appDeleget.saveContext()
            print("Data Delete")
        }
        catch {
            print("Could not save.")
        }
    }
    
}

