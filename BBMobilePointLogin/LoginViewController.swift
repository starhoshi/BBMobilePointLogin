//
//  LoginViewController.swift
//  BBMobilePointLogin
//
//  Created by Kensuke Hoshikawa on 2015/04/26.
//  Copyright (c) 2015年 star__hoshi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var at: UITextField!
    @IBOutlet weak var pass: UITextField!

    let userDefaults = NSUserDefaults.standardUserDefaults()
    let bbLoginWebView : UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInputText()
        if(validateInputText()){
            execLogin()
        }

        setBbLoginWebView()
        self.view.addSubview(bbLoginWebView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func login(sender: AnyObject) {
        setUserDefault()
        if(validateInputText()){
            execLogin()
        }else{
            alertNotInputValue()
        }
    }

    func setUserDefault(){
        userDefaults.setObject(userId.text, forKey: "userId")
        userDefaults.setObject(at.text, forKey: "at")
        userDefaults.setObject(pass.text, forKey: "pass")
    }

    func execLogin(){
        println("login")
    }

    func alertNotInputValue(){
        println("not input")
    }

    func validateInputText() -> Bool{
        if(userId.hasText() && at.hasText() && pass.hasText()){
            return true
        }
        return false
    }

    func setInputText(){
        userId.text = userDefaults.stringForKey("userId")
        at.text = userDefaults.stringForKey("at")
        pass.text = userDefaults.stringForKey("pass")

    }
    
    func setBbLoginWebView(){
        bbLoginWebView.delegate = self
        bbLoginWebView.frame = CGRectZero
        bbLoginWebView.scrollView.scrollsToTop = false
//        let url: NSURL = NSURL(string: "http://www.odn.ne.jp/")!
        let url: NSURL = NSURL(string: "http://tm.softbank.jp/business/wlan/set/welcome.html")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        bbLoginWebView.loadRequest(request)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println(webView)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if(webView.loading){
            return
        }
        if let currentUrl = webView.request?.URL!.absoluteString {
            println(currentUrl)
            switch currentUrl {
            case BBUrl.WELCOME.rawValue :
                println("Go Next!")
            case BBUrl.LOGIN.rawValue :
                var bBMobilePoint = BBMobilePoint(BBMobilePointWebView:bbLoginWebView)
                bBMobilePoint.login()
            default:
                println("other")
                break
            }
            //            application = bBMobilePoint.parseHtml()
            //            println(application)
        }
    }


}

private enum BBUrl: String {
    case WELCOME = "http://tm.softbank.jp/business/wlan/set/welcome.html"
    case LOGIN = "https://www.login4.w-lan.jp"
    case ODN = "http://www.odn.ne.jp/"
}
