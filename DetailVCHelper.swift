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
        
        myStackView.addArrangedSubview(textFieldName)
        myStackView.addArrangedSubview(textFieldSurName)
        myStackView.addArrangedSubview(textFieldFatherName)
        myStackView.addArrangedSubview(image)
        myStackView.addArrangedSubview(phoneLabel)
        myStackView.addArrangedSubview(textFieldTelephon)
        myStackView.addArrangedSubview(birthdayLabel)
        myStackView.addArrangedSubview(textFieldBithday)
        myStackView.addArrangedSubview(positionLabel)
        myStackView.addArrangedSubview(textFieldPosition)
        myStackView.addArrangedSubview(jobPhoneLabel)
        myStackView.addArrangedSubview(textFieldJobTelephon)
        myStackView.addArrangedSubview(personTypeLabel)
        myStackView.addArrangedSubview(personTypeTxt)
        myScrollView.addSubview(myStackView)
        view.addSubview(myScrollView)
        
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
  
        myStackView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
        myStackView.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor).isActive = true
        myStackView.rightAnchor.constraint(equalTo: myScrollView.rightAnchor).isActive = true
        myStackView.leftAnchor.constraint(equalTo: myScrollView.leftAnchor).isActive = true
        
        //   Важно! для веритикальной прокрутки!
        myStackView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        //
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
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
