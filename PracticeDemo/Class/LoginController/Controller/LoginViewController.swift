//
//  LoginViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import WebKit

#if DEBUG
    
    #endif

class LoginViewController: BaseViewController {

    
    lazy var mainWebView : WKWebView  = {
        let tempView = WKWebView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: 603));
        tempView.uiDelegate = self;
        tempView.navigationDelegate = self;
        //tempView.scrollView.delegate = self;
        return tempView;
    
    }()
    lazy var phoneTF :UITextField = {
        let tempField = UITextField.init(frame: CGRect.init(x: 20, y: 84, width: kScreenWidth - 40, height: 40))
        tempField.placeholder = "请输入手机号"
        tempField.keyboardType = UIKeyboardType.numberPad
        
        return tempField;
    }()
    
    lazy var searchText : UISearchBar = {
        let tempBar = UISearchBar.init(frame: CGRect.init(x: 20, y: phoneTF.frame.maxY + 20, width: kScreenWidth  - 40, height: 40))
        tempBar.delegate = self;
        tempBar.placeholder = "搜索"
        tempBar.layer.cornerRadius = 20;
        tempBar.layer.masksToBounds = true;
        return tempBar;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)), name:Notification.Name.UITextFieldTextDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        if #available(iOS 11.0, *) {
            mainWebView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        self.view.addSubview(mainWebView);
        mainWebView.load(URLRequest.init(url: URL.init(string: "http://www.baidu.com")!))
        
        
    
        
        // Do any additional setup after loading the view.
    }
    @objc func keyBoardWillShow(notification:NSNotification)-> () {
        
    }
    @objc func textFieldDidChange(notification:NSNotification) -> () {
        phoneTF.textColor = [UIColor.red,UIColor.orange,UIColor.green][(NSInteger) (arc4random() % 3)]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension LoginViewController : UIScrollViewDelegate {
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return nil;
//    }
//}
extension LoginViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
extension LoginViewController : WKUIDelegate {
    

    

}
extension LoginViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            let url = webView.url?.absoluteString
        
            print("url====\(url as Any)");
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
}
