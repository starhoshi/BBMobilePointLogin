//
//  ViewController.swift
//  BBMobilePointLogin
//
//  Created by Kensuke Hoshikawa on 2015/04/26.
//  Copyright (c) 2015年 star__hoshi. All rights reserved.
//

/**
*  UIWebViewDelegate は storyboard で設定
*/

import UIKit

class ViewController: UIViewController {

    let bbLoginUrl = "http://www.odn.ne.jp/"
    @IBOutlet weak var bbWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bbWebView.frame = self.view.bounds
        bbWebView.scrollView.scrollsToTop = false
        let url: NSURL = NSURL(string: bbLoginUrl)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        bbWebView.loadRequest(request)
        self.view.addSubview(bbWebView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

