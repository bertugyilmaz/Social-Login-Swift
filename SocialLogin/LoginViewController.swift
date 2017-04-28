//
//  ViewController.swift
//  SocialLogin
//
//  Created by Bertuğ YILMAZ on 27/04/2017.
//  Copyright © 2017 bertug. All rights reserved.
//

import UIKit
import FBSDKLoginKit
//import Alamofire
import SDWebImage

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let imageURL = "https://img.clipartfest.com/b68ba2ac07e002167057770f502dca3b_facebook-icon-vector-facebook-logo_512-512.png"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var FacebookButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(FBSDKAccessToken.current() == nil){
            print("---------------------------------------------------------------------------------------------------------")
            print("Not logged in ")
            print("---------------------------------------------------------------------------------------------------------")
        }else{
            print("---------------------------------------------------------------------------------------------------------")
            print("Logged in already")
            print("---------------------------------------------------------------------------------------------------------")
            getFacebookUserInfo()
        }
        
        FacebookButton.readPermissions = ["public_profile","email"]
        FacebookButton.delegate = self
        
    imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        
        if((error) != nil){
            print("Something going is wrong?")
        }else{
            print("Log-in")
            getFacebookUserInfo()
       }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("Log-out")
    }
    
    func getFacebookUserInfo(){
        let params = ["fields" : "email, name"]
        let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: params)
        
        let Connection = FBSDKGraphRequestConnection()
        
        Connection.add(graphRequest) { (Connection, result, error) in
            let info = result as! [String : AnyObject]
            print("---------------------------------------------------------------------------------------------------------")
            print(info)
            print("---------------------------------------------------------------------------------------------------------")
        }
        Connection.start()
    }
}

