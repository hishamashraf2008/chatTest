//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/7/20.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = true
        return view
    }()
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Enter your Email.."
        textField.backgroundColor = .white
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "First name"
        textField.backgroundColor = .white
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Last name"
        textField.backgroundColor = .white
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Enter your password"
        textField.backgroundColor = .white
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.link.cgColor
        return image
    }()
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up!", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        view.backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeImage))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        imageView.addGestureRecognizer(gesture)
        
        
        view.addSubview(scrollView)
        view.addSubview(imageView)
        scrollView.addSubview(firstNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, // centers image
                                 y: 140,
                                 width: size,
                                 height: size)   // "size" is used here because its square
        imageView.layer.cornerRadius = imageView.width/2
        firstNameTextField.frame = CGRect(x: 30,
                                      y: imageView.bottom+20,
                                      width: (scrollView.width-60)/2,
                                      height: 52)
        lastNameTextField.frame = CGRect(x: firstNameTextField.right+3 ,
                                      y: imageView.bottom+20,
                                      width: (scrollView.width-60)/2,
                                      height: 52)
        emailTextField.frame = CGRect(x: 30,
                                      y: firstNameTextField.bottom+10,
                                      width: scrollView.width-57,
                                      height: 52)
        
        passwordTextField.frame = CGRect(x: 30,
                                         y: emailTextField.bottom+10,
                                         width: scrollView.width-57,
                                         height: 52)
        
        registerButton.frame = CGRect(x: 50,
                                   y: passwordTextField.bottom+20,
                                   width: scrollView.width-90,
                                   height: 40)
        
    }
    @objc private func didTapChangeImage(){
        presentPhotoActionSheet()
    }
    @objc private func registerButtonTapped(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        
        // this code checks if the fields are NOT empty
        
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count>=6 else {
            alertUserLoginError()
            return
        }
        
    }
    
    func alertUserLoginError(){
        
        let alert = UIAlertController(title: "Something went wrong!", message: "Please enter all info to create a new account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            registerButtonTapped()
        }
        
        return true
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Choose your profile picture", message: "How would you like to choose your photo", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {[weak self]_ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: {[weak self]_ in
            self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}

        self.imageView.image = selectedImage
    }
}
