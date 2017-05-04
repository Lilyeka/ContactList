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
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        img.layer.cornerRadius = 70.0
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    var textFieldName: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Имя"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var textFieldSurName: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Фамилия"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var textFieldFatherName: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Отчество"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var textFieldTelephon: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Основной телефон"
        tf.borderStyle = .roundedRect
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
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var textFieldPosition: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Должность"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var textFieldJobTelephon: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.placeholder = "Рабочий телефон"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var myScrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.translatesAutoresizingMaskIntoConstraints = false
        return scrollV
    }()
    
    var myStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.backgroundColor = .green
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.alignment = .fill
        stackV.distribution = .equalSpacing
        stackV.spacing = 20.0
        return stackV
    }()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myScrollView.contentSize = myStackView.bounds.size
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowFunc(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideFunc(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
       // navigationController?.automaticallyAdjustsScrollViewInsets = true
       // navigationController?.extendedLayoutIncludesOpaqueBars = true
       // myScrollView.contentInset.top = 64.0
        myScrollView.contentInset.bottom = 20.0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Карточка контакта"
        rightBarButtons.append(UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(saveButtonAction)))
    
        navigationItem.rightBarButtonItem = rightBarButtons[0] //справа кнопка Готово
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
 
    func saveButtonAction(){// по кнопке Готово сохранение
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        if person == nil {  //если идет добавление то создаем новый объект кордата
            var person1 = Person(context: managedContext)
            person1.name = textFieldName.text
            person1.surname = textFieldSurName.text
            person1.phoneNumber = textFieldTelephon.text
            person1.fatherName = textFieldFatherName.text
            person1.birthday = textFieldBithday.text
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Keyboard Insets
    
    func keyboardShowFunc(notification: NSNotification){
        if myScrollView.contentInset.bottom <= 20{
            
            changeScrollView(showKeyboard: true, notification: notification)
        }
    }
    
    func keyboardHideFunc(notification: NSNotification){
        changeScrollView(showKeyboard: false, notification: notification)
    }
    
    func changeScrollView(showKeyboard: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height * (showKeyboard ? 1: -1)
        
        myScrollView.contentInset.bottom += keyboardHeight
        myScrollView.scrollIndicatorInsets.bottom += keyboardHeight
    }

}


