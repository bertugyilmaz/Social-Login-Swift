//
//  ViewController.swift
//  SocialLogin
//
//  Created by Bertuğ YILMAZ on 27/04/2017.
//  Copyright © 2017 bertug. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import Alamofire
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
            print("Not logged in ")
        }else{
            print("Logged in already")
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
            print("-----------------------------------")
            //FBSDKGraphRequest.init(graphPath: "/me", parameters: )
       }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("Log-out")
    }


}

