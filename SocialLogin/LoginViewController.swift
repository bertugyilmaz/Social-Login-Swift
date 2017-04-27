//
//  ViewController.swift
//  SocialLogin
//
//  Created by Bertuğ YILMAZ on 27/04/2017.
//  Copyright © 2017 bertug. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SDWebImage

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        
        if((error) != nil){
            print("Bir Hata Var")
        }else{
            print("Giriş Yapıldı!")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("Logout ..")
    }


}

