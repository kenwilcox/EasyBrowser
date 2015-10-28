//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Kenneth Wilcox on 10/19/15.
//  Copyright © 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  var webView: WKWebView!
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let url = NSURL(string: "http://www.starfall.com")!
    webView.loadRequest(NSURLRequest(URL: url))
    webView.allowsBackForwardNavigationGestures = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
    let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshTapped")
    
    toolbarItems = [spacer, refresh]
    navigationController?.toolbarHidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func openTapped() {
    let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .ActionSheet)
    ac.addAction(UIAlertAction(title: "apple.com", style: .Default, handler: openPage))
    ac.addAction(UIAlertAction(title: "loopinsight.com", style: .Default, handler: openPage))
    ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    
    if UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
      ac.modalPresentationStyle = .Popover
      ac.popoverPresentationController!.barButtonItem = navigationItem.rightBarButtonItem
    }
    
    presentViewController(ac, animated: true, completion: nil)
  }
  
  func openPage(action: UIAlertAction!) {
    let url = NSURL(string: "https://" + action.title!)!
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    webView.loadRequest(NSURLRequest(URL: url))
  }
  
  func refreshTapped() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    webView.reload()
  }
}

extension ViewController: WKNavigationDelegate {
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    title = webView.title
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }
}
