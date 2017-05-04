//
//  DetailViewController.swift
//  PersonContacts
//
//  Created by Лилия Левина on 18.04.17.
//  Copyright © 2017 Лилия Левина. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate {
    
    var person:Person? = nil
    var personTypes = ["Друг", "Коллега"]
    var picker = UIPickerView()
    
    let gesher = UITapGestureRecognizer()
    
    var rightBarButtons = [UIBarButtonItem]()
    //var leftBarButtons = [UIBarButtonItem]()
    
    var personTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Тип контакта:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var personTypeTxt: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Друг/Коллега"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
  var image: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10.0
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        return img
    }()
    
    var textFieldName: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Имя"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var textFieldSurName: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Фамилия"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var textFieldFatherName: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Отчество"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var textFieldTelephon: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Основной телефон"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "День рождения:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var jobPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Рабочий: "
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var positionLabel: UILabel = {
    let label = UILabel()
    label.text = "Должность: "
    label.font = UIFont.systemFont(ofSize: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()

    var textFieldBithday: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "дд.мм.гггг"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var textFieldPosition: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Должность"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var textFieldJobTelephon: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Рабочий телефон"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupData()
        setupViews()
        picker.delegate = self
        picker.dataSource = self
        personTypeTxt.inputView = picker
        
        self.hideKeyboardWhenTappedAround()
        
        textFieldName.delegate = self
        textFieldSurName.delegate = self
        textFieldFatherName.delegate = self
        textFieldTelephon.delegate = self
        textFieldBithday.delegate = self
        textFieldPosition.delegate = self
        textFieldJobTelephon.delegate = self
        personTypeTxt.delegate = self
    }
    
   override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = "Title"
       
        rightBarButtons.append(UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(saveButtonAction)))
    
        navigationItem.rightBarButtonItem = rightBarButtons[0] //справа кнопка Готово
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
 
    func saveButtonAction(){// по кнопке Готово
        print("SAVE!!!")
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        textFieldName.resignFirstResponder()
        textFieldSurName.resignFirstResponder()
        textFieldFatherName.resignFirstResponder()
        textFieldTelephon.resignFirstResponder()
        textFieldBithday.resignFirstResponder()
        textFieldPosition.resignFirstResponder()
        textFieldJobTelephon.resignFirstResponder()
      
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        if person == nil {  //если идет добавление то создаем новый объект кордата
            var person1 = Person(context: managedContext)
            person1.name = textFieldName.text
            person1.surname = textFieldSurName.text
            person1.phoneNumber = textFieldTelephon.text
            person1.fatherName = textFieldFatherName.text
            person1.birthday = textFieldBithday.text
            //UIImage(da)
            //  person?.image = image.image
            person1.imageBinary = UIImagePNGRepresentation(image.image!)! as NSData
            person1.position = textFieldPosition.text
            person1.jobPhoneNumber = textFieldJobTelephon.text
            if personTypeTxt.text == "Друг" {
                person1.personType = 1
            } else if personTypeTxt.text == "Коллега" {
                person1.personType = 2
            }
            
        }// если редактирование то передаем значения в person
        person?.name = textFieldName.text
        person?.surname = textFieldSurName.text
        person?.phoneNumber = textFieldTelephon.text
        person?.fatherName = textFieldFatherName.text
        person?.birthday = textFieldBithday.text
      //  person?.image = image.image
        person?.imageBinary = UIImagePNGRepresentation(image.image!)! as NSData
        person?.position = textFieldPosition.text
        person?.jobPhoneNumber = textFieldJobTelephon.text
        if personTypeTxt.text == "Друг" {
            person?.personType = 1
        } else if personTypeTxt.text == "Коллега" {
            person?.personType = 2
        }
        do{
            try(managedContext.save())
        } catch let err{
            print(err)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }

}


