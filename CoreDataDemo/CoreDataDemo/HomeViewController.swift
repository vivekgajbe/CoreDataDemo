//
//  HomeViewController.swift
//  CoreDataDemo
//
//  Created by vivek gajbe on 09/11/17.
//  Copyright © 2017 Vivek Gajbe. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {

    //MARK:- Variable declaration
    let imgPicker = UIImagePickerController()
    var userDetails: [NSManagedObject] = []
    var iKeybordHeight = Int()
    var strProfileUrl = String()
    
    
    //MARK:- Outlet declaration
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var txtFName: UITextField!
    @IBOutlet var txtLName: UITextField!
    @IBOutlet var txtGender: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtMobileNumber: UITextField!
    @IBOutlet var txtPincode: UITextField!
    @IBOutlet var txtOccupation: UITextField!
    @IBOutlet var txtPassport: UITextField!
    @IBOutlet var txtAadhar: UITextField!

    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnUpdate: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var viwContainer: UIView!
    @IBOutlet var scrlViwHome: UIScrollView!
    
    // MARK: - View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.title = "User form"
        imgPicker.delegate = self

        btnSave.layer.borderWidth = 1.0
        btnUpdate.layer.borderWidth = 1.0
        btnDelete.layer.borderWidth = 1.0
        
        btnSave.layer.cornerRadius = 15
        btnUpdate.layer.cornerRadius = 15
        btnDelete.layer.cornerRadius = 15
 
        self.txtFName.delegate = self
        self.txtLName.delegate = self
        self.txtGender.delegate = self
        self.txtCity.delegate = self
        self.txtEmail.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtPincode.delegate = self
        self.txtMobileNumber.delegate = self
        
        self.getUserDetails()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        //set rounder corner to image
        imgProfile.contentMode = .scaleAspectFill
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height / 2
        imgProfile.clipsToBounds = true
        
        //add tap gesture to hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.resignKeyboard))
        viwContainer.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - user define method 
    func resignKeyboard()
    {
        scrlViwHome.contentSize = CGSize(width: scrlViwHome.frame.size.width, height: viwContainer.frame.size.height )
        txtFName.resignFirstResponder()
        txtLName.resignFirstResponder()
        txtGender.resignFirstResponder()
        txtCity.resignFirstResponder()
        txtEmail.resignFirstResponder()
        txtMobileNumber.resignFirstResponder()
        txtPincode.resignFirstResponder()
        txtOccupation.resignFirstResponder()
        txtPassport.resignFirstResponder()
        txtAadhar.resignFirstResponder()
        
    }
    //fetch user details from coredata
    func getUserDetails()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let fetchRequest = NSFetchRequest<ProfileDetails>(entityName: "ProfileDetails")
            let _ : NSFetchRequest<ProfileDetails> = ProfileDetails.fetchRequest()
            
            //hide code as we dont need filteration
//            let newLength = txtFName.text?.characters.count
//            if newLength! > 0
//            {
//               fetchRequest.predicate = NSPredicate(format: "fName == %@", txtFName.text!)
//            }

            let fetchedResults = try context.fetch(fetchRequest) 
            if let aContact = fetchedResults.last
            {

                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                if let dirPath          = paths.first
                {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(aContact.imgProfile!)
                    imgProfile.image    = UIImage(contentsOfFile: imageURL.path)
                }
                
                txtFName.text = aContact.fName
                txtLName.text = aContact.lName
                txtGender.text = aContact.gender
                txtCity.text = aContact.city
                txtEmail.text = aContact.email
                txtMobileNumber.text = aContact.mobileNumber
                txtPincode.text = aContact.lName
                txtOccupation.text = aContact.occupation
                txtAadhar.text = aContact.aadhar
                txtPassport.text = aContact.passport
                
                self.disableTextFeildAction()
            }
        }
        catch {
            print ("fetch task failed", error)
        }
    }
    func fetchRequest() -> NSFetchRequest<ProfileDetails>
    {
        return NSFetchRequest<ProfileDetails>(entityName: "ProfileDetails")
    }
    
    //disable manditory field to edit
    func disableTextFeildAction()
    {
        self.txtFName.alpha = 0.6
        self.txtLName.alpha = 0.6
        self.txtGender.alpha = 0.6
        self.txtCity.alpha = 0.6
        self.txtEmail.alpha = 0.6
        self.txtMobileNumber.alpha = 0.6
        self.txtPincode.alpha = 0.6
        self.txtMobileNumber.alpha = 0.6

        self.txtFName.isUserInteractionEnabled = false
        self.txtLName.isUserInteractionEnabled = false
        self.txtGender.isUserInteractionEnabled = false
        self.txtCity.isUserInteractionEnabled = false
        self.txtEmail.isUserInteractionEnabled = false
        self.txtMobileNumber.isUserInteractionEnabled = false
        self.txtPincode.isUserInteractionEnabled = false
        self.txtMobileNumber.isUserInteractionEnabled = false
    }
    //enable manditory field to edit
    func enableTextFeildAction()
    {
        self.txtFName.alpha = 1.0
        self.txtLName.alpha = 1.0
        self.txtGender.alpha = 1.0
        self.txtCity.alpha = 1.0
        self.txtEmail.alpha = 1.0
        self.txtMobileNumber.alpha = 1.0
        self.txtPincode.alpha = 1.0
        self.txtMobileNumber.alpha = 1.0
        
        self.txtFName.isUserInteractionEnabled = true
        self.txtLName.isUserInteractionEnabled = true
        self.txtGender.isUserInteractionEnabled = true
        self.txtCity.isUserInteractionEnabled = true
        self.txtEmail.isUserInteractionEnabled = true
        self.txtMobileNumber.isUserInteractionEnabled = true
        self.txtPincode.isUserInteractionEnabled = true
        self.txtMobileNumber.isUserInteractionEnabled = true
        
    }
    //set empty to form
    func setEmptyToTextFeild()
    {
        imgProfile.image = UIImage(named: "Profile")
        self.txtFName.text = ""
        self.txtLName.text = ""
        self.txtGender.text = ""
        self.txtCity.text = ""
        self.txtEmail.text = ""
        self.txtMobileNumber.text = ""
        self.txtPincode.text = ""
        self.txtMobileNumber.text = ""
        self.txtOccupation.text = ""
        self.txtAadhar.text = ""
        self.txtPassport.text = ""
        
    }
    //validate form details
    func validate() -> Bool
    {
        if imgProfile.image == UIImage(named: "Profile")
        {
            self.showAlert(strMessage: "Please select Profile Picture")
            return false
        }
        else
        if let text = txtFName.text, text.isEmpty
        {
           self.showAlert(strMessage: "Please enter First Name")
            return false
        }
        else
        if let text = txtLName.text, text.isEmpty
        {
            self.showAlert(strMessage: "Please enter Last Name")
            return false
        }
        else
        if let text = txtGender.text, text.isEmpty
        {
            self.showAlert(strMessage: "Please enter Gender")
            return false
        }
        else
        if let text = txtCity.text, text.isEmpty
        {
            self.showAlert(strMessage: "Please enter City")
            return false
        }
        else
        if let text = txtEmail.text, text.isEmpty
        {
            self.showAlert(strMessage: "Please enter email")
            return false
        }
        else
        if let text = txtMobileNumber.text, text.isEmpty
        {
            self.showAlert(strMessage: "Please enter Mobile Number")
            return false
        }
        else
        if let text = txtPincode.text, text.isEmpty
        {
            self.showAlert(strMessage: "Please enter pin code")
            return false
        }
        else
        if let text = txtEmail.text
        {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailTest.evaluate(with: text) == false
            {
                self.showAlert(strMessage: "Please enter valid email")
                return false
            }
        }
        return true
    }
    //show common alert on screen
    func showAlert(strMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: strMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //Open camera on screen
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imgPicker.sourceType = .camera
            self.present(imgPicker, animated: true, completion: nil)
        }
        else
        {
            self.showAlert(strMessage: "You don't have camera")
        }
    }
    //Open gallary on screen
    func openGallary()
    {
        imgPicker.allowsEditing = false
        imgPicker.sourceType = .photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
    //Save profile image in documnet directory
    func SavePofileImage(imgProfile:UIImageView)
    {
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let strProfileName = "profile.png"
            strProfileUrl = strProfileName
            let fileURL = documentsURL.appendingPathComponent(strProfileName)
            
            if let pngImageData = UIImagePNGRepresentation(imgProfile.image!)
            {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        }
        catch
        {
        }
    }
    //MARK: - Image delegate method
    //set profile image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgProfile.contentMode = .scaleAspectFill
            imgProfile.image = pickedImage
            
            imgProfile.layer.cornerRadius = imgProfile.frame.size.height / 2

            imgProfile.clipsToBounds = true
            self.SavePofileImage(imgProfile: imgProfile)
        }
        
        dismiss(animated: true, completion: nil)
    }
    //dismiss image picker once user click on cancel in between
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
    dismiss(animated: true, completion: nil)
    }
    // MARK: - Button Delegate method
    //Save form
    @IBAction func saveUserForm(_ sender: Any)
    {
        if self.validate()
        {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            if #available(iOS 10.0, *) {
                let managedContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "ProfileDetails",
                                                        in: managedContext)!
                
                let person = NSManagedObject(entity: entity,
                                             insertInto: managedContext)
                person.setValue(strProfileUrl, forKey: "imgProfile")
                
                person.setValue(txtFName.text, forKeyPath: "fName")
                person.setValue(txtLName.text, forKeyPath: "lName")
                person.setValue(txtGender.text, forKeyPath: "gender")
                person.setValue(txtCity.text, forKeyPath: "city")
                person.setValue(txtEmail.text, forKeyPath: "email")
                person.setValue(txtMobileNumber.text, forKeyPath: "mobileNumber")
                person.setValue(txtPincode.text, forKeyPath: "pincode")
                person.setValue(txtOccupation.text, forKeyPath: "occupation")
                person.setValue(txtPassport.text, forKeyPath: "passport")
                person.setValue(txtAadhar.text, forKeyPath: "aadhar")
                
                do {
                    try managedContext.save()
                    userDetails.append(person)
                    self.showAlert(strMessage: "User details save successfully")
                    self.disableTextFeildAction()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            }
            else
            {
                // Fallback on earlier versions
                //As NSPersistentContainer is avialable from ios 10
                //It help us to do multiple task
            }
        }
    }
    //open actionsheet to select profile image
    @IBAction func btnSelectProfilePic(_ sender: Any)
    {
        let actionSheet = UIAlertController.init(title: "Please choose a source type", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: "Take Photo", style: .default, handler: { (action) in
            print("camera")
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Choose Photo", style: UIAlertActionStyle.default, handler: { (action) in
            print("gallery")
            self.openGallary()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            //If you tap outside the UIAlertController action buttons area, then also this handler gets called.
        }))
        //Present the controller
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    //update form click
    @IBAction func btnUpdateClick(_ sender: Any)
    {
        self.enableTextFeildAction()
        self.showAlert(strMessage: "User details allow to update")
        //self.saveUserForm(btnSave)
    }
    //delete form click
    @IBAction func btnDeleteClick(_ sender: Any)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ProfileDetails>(entityName: "ProfileDetails")
            
               // try managedContext.save()
                if let result = try? managedContext.fetch(fetchRequest) {
                    for object in result {
                        managedContext.delete(object)
                        do {
                            try managedContext.save() // <- remember to put this :)
                        } catch {
                            
                        }
                        
                        self.setEmptyToTextFeild()
                        self.enableTextFeildAction()
                        self.showAlert(strMessage: "User details delete successfully")
                    }
                }
        }
    }
    
    //MARK:- text feild delegate method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        //Add action sheet to select gender
        if textField == txtGender
        {
            
            let actionSheet = UIAlertController.init(title: "Please choose Gender", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction.init(title: "Male", style: .default, handler: { (action) in
                self.txtGender.text = "Male"
                print("Male")
                
            }))
            actionSheet.addAction(UIAlertAction.init(title: "Female", style: UIAlertActionStyle.default, handler: { (action) in
                print("Female")
                self.txtGender.text = "Female"
                
            }))
            actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
                //If you tap outside the UIAlertController action buttons area, then also this handler gets called.
            }))
            //Present the controller
            self.present(actionSheet, animated: true, completion: nil)
            self.resignKeyboard()
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        
        if textField == txtMobileNumber && newLength > 10
        {
        return false
        }
        else
        if textField == txtPincode && newLength > 6
        {
            return false
        }
        else
            if textField == txtAadhar && newLength > 16
            {
                return false
        }
       return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        scrlViwHome.contentSize = CGSize(width: scrlViwHome.frame.size.width, height: viwContainer.frame.size.height )
        return true
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            scrlViwHome.contentSize = CGSize(width: scrlViwHome.frame.size.width, height: viwContainer.frame.size.height + keyboardHeight)
            iKeybordHeight = Int(keyboardHeight)
            
        }
    }
    

}
