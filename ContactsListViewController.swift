//
//  ContactsListViewController.swift
//  PersonContacts
//
//  Created by Лилия Левина on 17.04.17.
//  Copyright © 2017 Лилия Левина. All rights reserved.
//

import UIKit
import CoreData

private let cellId = "cellID"
private let cellId1 = "cellID1"

private let headerId = "headerId"
/*private let footerId = "footerId"*/

class ContactsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var persons: [Person]? = nil
    var friends = [Person]()
    var collegues = [Person]()
    var dataInitialized: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        //clearData()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        collectionView!.collectionViewLayout = layout
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"+", style: .done, target: self, action: #selector(addPerson))
        // Register cell classes
        collectionView!.register(ContactCellF.self, forCellWithReuseIdentifier: cellId)
        collectionView!.register(ContactCellC.self, forCellWithReuseIdentifier: cellId1)
        collectionView!.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        /*collectionView!.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)*/
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        var results : NSArray?
        do{
             results = try(managedContext.fetch(Person.fetchRequest()) as NSArray)
        } catch let err{
            print(err)
        }
        if results?.count == 0 { // если коре дата пустая то записываем в нее демо-данные
            demoData()
        } else { loadData()} //иначе загружаем данные из коре дата
    }
    
    func addPerson(){
        let detailVC = DetailViewController()
        detailVC.person = nil
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return friends.count
        } else if section == 1 {
            return collegues.count
        } else {
            return 0
        }
    }
    
    
    //---header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
            header.type = indexPath.section
            header.backgroundColor = UIColor(red: 196/255, green: 211/255, blue: 229/255, alpha: 1)
            return header
        }
        return UICollectionReusableView()
        /* else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            footer.backgroundColor = .green
            return footer
        }*/
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30.0)
    }
    
    //--------footer size
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }*/

    //------cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentPerson:Person?
        
        if indexPath.section == 0 {
            var cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactCellF
            currentPerson = friends[indexPath.row]
            cell1.person = currentPerson
            return cell1
        } else if indexPath.section == 1 {
            var cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! ContactCellC
            currentPerson = collegues[indexPath.row]
            cell1.person = currentPerson
            return cell1
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cg = CGSize()
        if indexPath.section == 0 {
         cg = CGSize(width: view.frame.width, height: 110.0)
        }  else if indexPath.section == 1{
         cg = CGSize(width: view.frame.width, height: 140.0)
        }
        return cg
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: nil, bundle: nil)
        let currentPerson:Person?
        if indexPath.section == 0 {
            currentPerson = friends[indexPath.row]
            detailVC.person = currentPerson
        } else if indexPath.section == 1{
            currentPerson = collegues[indexPath.row]
            detailVC.person = currentPerson
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }



}
