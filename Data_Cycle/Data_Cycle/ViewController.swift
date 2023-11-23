//
//  ViewController.swift
//  Data_Cycle
//
//  Created by YOU on 11/23/23.
//


import UIKit
import CoreData

class ViewController: UIViewController {
   
    @IBOutlet var viewImage: UIImageView!
    @IBOutlet var name: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var status: UILabel!
    
    // 관리 객체 컨텍스트 객체에 대한 참조를 저장할 변수를 선언
    var manageObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCoreData()
        
    }
    
    func initCoreData() {
        let container = NSPersistentContainer(name: "Data_Cycle")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error{
                fatalError("failed init: \(error)")
            }else {
                self.manageObjectContext = container.viewContext
            }
        })
    }
    
    @IBAction func borrow(_ sender: Any) {
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "Cycle", in: context) {
            let cycle = Cycle(entity:entityDescription, insertInto: manageObjectContext)
            
            cycle.name = name.text
            cycle.password = password.text
            
            do{
                try manageObjectContext?.save()
                name.text = ""
                password.text = ""
                status.text = "따릉따릉 따릉이 시작합니다."
                
            }catch let error {
                status.text = "따릉이를 이미 사용중 입니다. \(error.localizedDescription)"
            }
        }
    }
    
    @IBAction func finding(_ sender: Any) {
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "Cycle", in: context) {
            
            let request: NSFetchRequest<Cycle> = Cycle.fetchRequest()
            request.entity = entityDescription //?
            
            if let name = name.text {
                let pred = NSPredicate(format: "(name = %@)", name)
                request.predicate = pred
            }
            do {
                let result = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                if result.count > 0 {
                    let matching  = result[0] as! NSManagedObject
                    name.text = matching.value(forKey: "name") as? String
                    password.text = matching.value(forKey: "password") as? String
                   
                    if  let statusName = matching.value(forKey: "name") as? String {
                        status.text = "\(statusName)이 사용중 입니다."
                    }
                    
                }else{
                    status.text = "사용중인 따릉이를 찾을 수 없습니다."
                }
            }catch let error{
                status.text = error.localizedDescription
            }
        }
    }
    
    @IBAction func returnedCycle(_ sender: Any) {
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "Cycle", in: context) {
            
            let request: NSFetchRequest<Cycle> = Cycle.fetchRequest()
            request.entity = entityDescription //?
            
            if let name = name.text {
                let pred = NSPredicate(format: "(name = %@)", name)
                request.predicate = pred
            }
            do {
                let result = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                if result.count > 0 {
                    let matching  = result[0] as! NSManagedObject
                    context.delete(matching)
                    name.text = ""
                    password.text = ""
                    status.text = "따릉이가 반납되었습니다"
                    
                    do{
                        try context.save()
                        
                    }catch let error {
                        print("\(error.localizedDescription)")
                    }
                    
                }else{
                    status.text = "사용중인 따릉이를 찾을 수 없습니다. 어서 따릉이를 이용하세요!"
                }
            }catch let error{
                status.text = error.localizedDescription
            }

            
        }
    }
}
