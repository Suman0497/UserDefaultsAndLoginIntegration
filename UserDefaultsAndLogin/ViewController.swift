//
//  ViewController.swift
//  UserDefaultsAndLogin
//
//  Created by apple on 26/09/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
      @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let email = "suman@gmail.com"
    let password = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = 15
    
        
        let leftImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
                      leftImage.tintColor = .gray
                      leftImage.image = UIImage(systemName: "envelope")
                      
                      let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                      leftView.addSubview(leftImage)
                      
                      txtEmail.leftViewMode = .always
                      txtEmail.leftView = leftView
                      
                      
                      //right view
                      
                      let rightImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
                      rightImage.tintColor = .gray
                      rightImage.image = UIImage(systemName: "lock")
                      
                      let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                      rightView.addSubview(rightImage)
                      
                      txtPassword.rightViewMode = .always
                      txtPassword.rightView = rightView

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickLogin(_ sender: Any) {
        if email == txtEmail.text! && password == txtPassword.text! {
            UserDefaults.standard.set(txtEmail.text!, forKey: "email")
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
            navigationController?.pushViewController(vc!, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Email or password is not matching", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func fbLogin() {
               let loginManager = LoginManager()
               loginManager.logOut()
               loginManager.logIn(permissions:[ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
                   
                   switch loginResult {
                   
                   case .failed(let error):
                       print(error)
                   
                   case .cancelled:
                       print("User cancelled login process.")
                   
                   case .success( _, _, _):
                       print("Logged in!")
                       self.getFBUserData()
                   }
               }
           }
           
           func getFBUserData() {
            
               if((AccessToken.current) != nil){
                   
                   GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                       if (error == nil){
                           
                           let dict = result as! [String : AnyObject]
                           print(result!)
                           print(dict)
                           let picutreDic = dict as NSDictionary
                           let tmpURL1 = picutreDic.object(forKey: "picture") as! NSDictionary
                           let tmpURL2 = tmpURL1.object(forKey: "data") as! NSDictionary
                           let finalURL = tmpURL2.object(forKey: "url") as! String
                           
                           let nameOfUser = picutreDic.object(forKey: "name") as! String
    //                       self.lblUserName.text = nameOfUser
                           
                           var tmpEmailAdd = ""
                           if let emailAddress = picutreDic.object(forKey: "email") {
                               tmpEmailAdd = emailAddress as! String
    //                           self.lblUserEmail.text = tmpEmailAdd
                           }
                           else {
                               var usrName = nameOfUser
                               usrName = usrName.replacingOccurrences(of: " ", with: "")
                               tmpEmailAdd = usrName+"@facebook.com"
                           }
                           
                       }
                       
                       print(error?.localizedDescription as Any)
                   })
               }
           }

        @IBAction func fbButtonTapped(_ sender: Any) {
            fbLogin()

        }
    
}

