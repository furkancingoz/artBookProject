//
//  DetailsVC.swift
//  artBookProject
//
//  Created by Furkan Cingöz on 14.09.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yearText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var nameText: UITextField!
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenPainting != "" {
           // let stringUUID = chosenPaintingId?.uuidString
           // print(stringUUID)
            
            
            
            
        } else {
            print("boşluk")
        }
        
        
        //Recongnizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonTik(_ sender: UIButton) {
        
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelgate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Atributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        let data  = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("succes")
        } catch {
            print("error")
    }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    
   

}
