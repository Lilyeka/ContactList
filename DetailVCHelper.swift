//
//  DetailVCHelper.swift
//  PersonContacts
//
//  Created by Лилия Левина on 20.04.17.
//  Copyright © 2017 Лилия Левина. All rights reserved.
//

import UIKit
import CoreData

extension DetailViewController{
    
    func setupData(){
        if let currentPerson = person {
            if currentPerson.imageBinary != nil {
                image.image =  UIImage(data: (currentPerson.imageBinary as! NSData) as Data)//UIImage(named: currentPerson.image!)
            } else {
                image.image = #imageLiteral(resourceName: "imagePlaceholder")
            }
            textFieldName.text = currentPerson.name
            textFieldSurName.text = currentPerson.surname
            textFieldFatherName.text = currentPerson.fatherName
            textFieldTelephon.text = currentPerson.phoneNumber
            textFieldBithday.text = currentPerson.birthday
            textFieldPosition.text = currentPerson.position
            textFieldJobTelephon.text = currentPerson.jobPhoneNumber
            if currentPerson.personType == 1 {
                personTypeTxt.text = "Друг"
            } else if currentPerson.personType == 2 {
                personTypeTxt.text = "Коллега"
            }
        }
        else {
            image.image = #imageLiteral(resourceName: "imagePlaceholder")
            personTypeTxt.text = "Друг"
        }
        gesher.addTarget(self, action: #selector(selectPhoto))
        image.addGestureRecognizer(gesher)
    }
    
    
    func setupViews(){
        view.addSubview(textFieldName)
        view.addSubview(textFieldSurName)
        view.addSubview(textFieldFatherName)
        view.addSubview(image)
        view.addSubview(textFieldTelephon)
        view.addSubview(textFieldBithday)
        view.addSubview(textFieldPosition)
        view.addSubview(textFieldJobTelephon)
        view.addSubview(personTypeLabel)
        view.addSubview(personTypeTxt)
        view.addSubview(birthdayLabel)
        view.addSubview(phoneLabel)
        view.addSubview(positionLabel)
        view.addSubview(jobPhoneLabel)
        
        image.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 12.0).isActive = true
        image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12.0).isActive = true
        image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        image.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        textFieldName.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 12.0).isActive = true
        textFieldName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        textFieldName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        textFieldSurName.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 12.0).isActive = true
        textFieldSurName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        textFieldSurName.rightAnchor.constraint(equalTo: textFieldName.rightAnchor).isActive = true
        
        textFieldFatherName.topAnchor.constraint(equalTo: textFieldSurName.bottomAnchor, constant: 12.0).isActive = true
        textFieldFatherName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        textFieldFatherName.rightAnchor.constraint(equalTo: textFieldSurName.rightAnchor).isActive = true
        
        personTypeLabel.topAnchor.constraint(equalTo: textFieldFatherName.bottomAnchor, constant: 24.0).isActive = true
        personTypeLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        personTypeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        personTypeTxt.topAnchor.constraint(equalTo: personTypeLabel.bottomAnchor, constant: 4.0).isActive = true
        personTypeTxt.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        personTypeTxt.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        birthdayLabel.topAnchor.constraint(equalTo: personTypeTxt.bottomAnchor, constant: 24.0).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        birthdayLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        textFieldBithday.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 4.0).isActive = true
        textFieldBithday.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12.0).isActive = true
        textFieldBithday.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2.0).isActive = true
        phoneLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12.0).isActive = true
        
        textFieldTelephon.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2.0).isActive = true
        textFieldTelephon.leftAnchor.constraint(equalTo: phoneLabel.rightAnchor, constant: 4.0).isActive = true
        textFieldTelephon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        positionLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4.0).isActive = true
        positionLabel.leftAnchor.constraint(equalTo: phoneLabel.leftAnchor).isActive = true
        //positionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        textFieldPosition.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4.0).isActive = true
        textFieldPosition.leftAnchor.constraint(equalTo: positionLabel.rightAnchor).isActive = true
        textFieldPosition.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        jobPhoneLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 4.0).isActive = true
        jobPhoneLabel.leftAnchor.constraint(equalTo: positionLabel.leftAnchor).isActive = true
       // textFieldPosition.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
        textFieldJobTelephon.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 4.0).isActive = true
        textFieldJobTelephon.leftAnchor.constraint(equalTo: jobPhoneLabel.rightAnchor, constant: 12.0).isActive = true
        textFieldJobTelephon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        
       
    }
    
    //MARK: UIPickerController
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int{
        return personTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        personTypeTxt.text = personTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  personTypes[row]
    }
    
    //MARK: UIImagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //print(info)
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else  if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            image.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func selectPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
}
