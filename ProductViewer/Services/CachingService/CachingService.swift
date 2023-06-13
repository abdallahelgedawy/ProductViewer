//
//  CachingService.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
import CoreData
import UIKit
class CachingService{
    let context: NSManagedObjectContext?
       static let getInstance = CachingService()
      private init() {
          print("single object created")
          let appDelegate=UIApplication.shared.delegate as! AppDelegate
          context=appDelegate.persistentContainer.viewContext
       }
    func insertProduct(product:ProductClass,completion : @escaping (Bool)-> Void){
           let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "Products")
           do{
               let entity=try NSEntityDescription.entity(forEntityName: "Products", in: context!)
                   let myproduct=NSManagedObject(entity: entity!, insertInto: context)
                   myproduct.setValue(product.imageURL, forKey: "image")
                   myproduct.setValue(product.name, forKey: "name")
                   myproduct.setValue(product.price, forKey: "price")
                   myproduct.setValue(product.description, forKey: "myDescription")
                   try  context?.save()
                   print("added successfully")
                   completion(true)
               }catch{
                   print("an error occured in add")
                   completion(false)
               }
       }
    func getAllProducts(completion : @escaping ([ProductClass]?)-> Void){
        var retrievedArray = [ProductClass]()
        let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "Products")
        do{
            let allProducts=try context!.fetch(fetchRequest)
            for product in allProducts {
                let Productsaved = ProductClass(id: "", name: product.value(forKey: "name") as! String, description: product.value(forKey: "myDescription") as! String, price: product.value(forKey: "price") as! String, unitPrice: nil, productTypeID: nil, imageURL: product.value(forKey: "image") as! String, shoppingListItemID: nil, shoppingCartItemID: nil)
                retrievedArray.append(Productsaved)
                print(Productsaved.name)
            }
            print(retrievedArray.count)
            print("data retrived succsessfully")
            completion(retrievedArray)
        }catch{
            print("error")
            completion(nil)
            
        }
    }

}
