//
//  ViewController.swift
//  SocialLogin
//
//  Created by Bertuğ YILMAZ on 27/04/2017.
//  Copyright © 2017 bertug. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SDWebImage
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {
    
    let imageURL = "https://www.1plusx.com/app/mu-plugins/all-in-one-seo-pack-pro/images/default-user-image.png"

    @IBOutlet weak var linkedButton : UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var faacebookButton: UIButton!
    
    var AccessToken: LISDKAccessToken!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.linkedButton.addTarget(self, action: #selector(linkedinLoginAction), for: .touchUpInside)
        self.faacebookButton.addTarget(self, action: #selector(getFacebookUserInfo), for: .touchUpInside)
        
        if(FBSDKAccessToken.current() == nil){
            print("Not logged in ")
        }else{
            print("Logged in already")
            getFacebookUserInfo()
        }
        imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func UserLogInAction(_ sender: Any) {
        let userName = "bertug@test.com"
        let userPassword = "test"
        
        if (userName == UsernameTextField.text || userPassword == PasswordTextField.text){
            print("Log-in")
            self.performSegue(withIdentifier: "mainMenu", sender: self)
        }
    }
    
    func linkedinLoginAction(sender:UIButton){
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: "", showGoToAppStoreDialog: true, successBlock: { (response : String?) in
            let url = "https://api.linkedin.com/v1/people/~"
            guard let session = LISDKSessionManager.sharedInstance().session else{
                return
            }
            self.AccessToken = session.accessToken
            print("Token --> \(self.AccessToken)")
            
            LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                print(response?.data as Any)
                self.performSegue(withIdentifier: "mainMenu", sender: self)
            }, error: { (error) in
                print(error as Any)
               })
            }) { (error:Error?) in
            print(error as Any)
        }
    }
    
    func getFacebookUserInfo(){
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email ], viewController: self) { (result) in
            switch result{
            case .cancelled:
                print("Cancel button click")
            case .success:
                let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
                let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: params)
                let Connection = FBSDKGraphRequestConnection()
                
                Connection.add(graphRequest) { (Connection, result, error) in
                    let info = result as! [String : AnyObject]
                    print(info)
                self.performSegue(withIdentifier: "mainMenu", sender: self)
                }
                Connection.start()
            default:
                print("??")
            }
        }
    }
}

