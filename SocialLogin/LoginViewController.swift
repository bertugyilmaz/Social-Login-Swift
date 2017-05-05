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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let imageURL = "https://img.clipartfest.com/b68ba2ac07e002167057770f502dca3b_facebook-icon-vector-facebook-logo_512-512.png"

    @IBOutlet weak var linkedButton : UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var FacebookButton: FBSDKLoginButton!
    var AccessToken: LISDKAccessToken!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.linkedButton.addTarget(self, action: #selector(linkedinLoginAction), for: .touchUpInside)
        
        if(FBSDKAccessToken.current() == nil){
            print("Not logged in ")
        }else{
            print("Logged in already")
            getFacebookUserInfo()
        }
        
        FacebookButton.readPermissions = ["public_profile","email"]
        FacebookButton.delegate = self
        
        imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func linkedinLoginAction(sender:UIButton){
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: "", showGoToAppStoreDialog: true, successBlock: { (response : String?) in
            let url = "https://api.linkedin.com/v1/people/~?format=json"
            guard let session = LISDKSessionManager.sharedInstance().session else{
                return
            }
            self.AccessToken = session.accessToken
            print("Token --> \(self.AccessToken)")
            
            LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                print(response?.headers)
            }, error: { (error) in
                print(error)
            })
        }) { (error:Error?) in
            print(error as Any)
        }
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
            
            print(info)
        }
        Connection.start()
    }
}

