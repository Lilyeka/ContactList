//
//  ContactCell.swift
//  PersonContacts
//
//  Created by Лилия Левина on 18.04.17.
//  Copyright © 2017 Лилия Левина. All rights reserved.
//

import Foundation
import UIKit

class Header: UICollectionViewCell{
    var type: Int?{
        didSet{
            if let tp = type {
                if tp == 0{
                    labelName.text = "Друзья"
                } else if tp == 1{
                    labelName.text = "Коллеги"
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        addSubview(labelName)
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

// Ячейки для друзей
class ContactCellF: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var person: Person?{
        didSet{
            if let pers = person {
                if let father = pers.fatherName{
                    labelName.text = pers.name! + " " + father + " " +  pers.surname!
                } else {
                    labelName.text = pers.name! + " " +  pers.surname!
                }
                labelTelephon.text =  pers.phoneNumber
                labelBithday.text = pers.birthday
                labelBithdayName.text = "День рождения: "
                //labelPosition.text = pers.position
                //labelJobTelephon.text = pers.jobPhoneNumber
                if pers.imageBinary != nil{
                    image.image = UIImage(data: (pers.imageBinary as! NSData) as Data)
                }
                    else {
                    image.image = #imageLiteral(resourceName: "imagePlaceholder")
                }
            }
        }
    }
    
    var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 34
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTelephon: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var labelBithdayName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var labelBithday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    
    func setupViews(){
        backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        addSubview(image)
        addSubview(labelName)
        addSubview(labelTelephon)
        addSubview(labelBithday)
        addSubview(labelBithdayName)
  
        
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        image.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        
        labelName.topAnchor.constraint(equalTo: image.topAnchor).isActive = true
        labelName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        labelName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        
        labelTelephon.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4.0).isActive = true
        labelTelephon.leftAnchor.constraint(equalTo: labelName.leftAnchor).isActive = true
        labelTelephon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        
        labelBithdayName.topAnchor.constraint(equalTo: labelTelephon.bottomAnchor, constant: 4.0).isActive = true
        labelBithdayName.leftAnchor.constraint(equalTo: labelTelephon.leftAnchor).isActive = true
       //labelBithdayName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -52.0).isActive = true
        
        labelBithday.topAnchor.constraint(equalTo: labelTelephon.bottomAnchor, constant: 4.0).isActive = true
        labelBithday.leftAnchor.constraint(equalTo: labelBithdayName.rightAnchor).isActive = true
        labelBithday.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has not been implemented ")
    }
}

//ячейки для Коллег
class ContactCellC: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var person: Person?{
        didSet{
            if let pers = person {
                if let father = pers.fatherName{
                    labelName.text = pers.name! + " " + father + " " +  pers.surname!
                } else {
                    labelName.text = pers.name! + " " +  pers.surname!
                }
                labelTelephon.text =  pers.phoneNumber
                labelPosition.text = pers.position
                labelJobTelephon.text = pers.jobPhoneNumber
                if pers.imageBinary != nil{
                    image.image = UIImage(data: (pers.imageBinary as! NSData) as Data)
                } else {
                    image.image = #imageLiteral(resourceName: "imagePlaceholder")
                }
            }
        }
    }
    
    var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 34
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTelephon: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelPosition: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelJobTelephon: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        addSubview(image)
        addSubview(labelName)
        addSubview(labelTelephon)
        addSubview(labelPosition)
        addSubview(labelJobTelephon)
        
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        image.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        
        labelName.topAnchor.constraint(equalTo: image.topAnchor).isActive = true
        labelName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        labelName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        
        labelTelephon.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4.0).isActive = true
        labelTelephon.leftAnchor.constraint(equalTo: labelName.leftAnchor).isActive = true
        labelTelephon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true

        labelPosition.topAnchor.constraint(equalTo:labelTelephon.bottomAnchor, constant: 4.0).isActive = true
        labelPosition.leftAnchor.constraint(equalTo: labelTelephon.leftAnchor).isActive = true
        labelPosition.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        
        labelJobTelephon.topAnchor.constraint(equalTo: labelPosition.bottomAnchor, constant: 4.0).isActive = true
        labelJobTelephon.leftAnchor.constraint(equalTo: labelPosition.leftAnchor).isActive = true
        labelJobTelephon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has not been implemented ")
    }
}

