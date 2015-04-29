//
//  BBMobilePoint.swift
//  BBMobilePointLogin
//
//  Created by Kensuke Hoshikawa on 2015/04/26.
//  Copyright (c) 2015年 star__hoshi. All rights reserved.
//


import Foundation
import UIKit

class BBMobilePoint{

    let bbLoginWebView:UIWebView!
    let html:String!

    /**

    :param: BBMobilePointHtml <#BBMobilePointHtml description#>

    :returns: <#return value description#>
    */
    init(BBMobilePointWebView:UIWebView){
        bbLoginWebView = BBMobilePointWebView
        let js = "document.body.innerHTML"
        html = bbLoginWebView.stringByEvaluatingJavaScriptFromString(js)
    }

    /**

    :param: html <#html description#>
    */
    func setParametor(){

    }

    func login() -> Bool{
        var err : NSError?
        let option = CInt(HTML_PARSE_NOERROR.value | HTML_PARSE_RECOVER.value)
        let parser     = HTMLParser(html: html, encoding: NSUTF8StringEncoding, option: option, error: &err)
        if err != nil {
            println(err)
            exit(1)
        }
        
        let bodyNode = parser.body
        var applicationDetail = [String:Any]()
        var application:[[String:Any]] = []
        
        if let path = bodyNode?.xpath("//div[@class='stream-item oauth-application ']") {
            for node in path {
                // iOSアプリの許可を取り消す方法はこちら
                if (node.findChildTagAttr("a", attrName: "class", attrValue: "revoke ios-revoke-access") != nil){
                    continue
                }
                applicationDetail = getApplicationData(node)
                application.append(applicationDetail)
            }
        }


        return true
    }


}