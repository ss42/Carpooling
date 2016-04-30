//
//  SendMailViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/29/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import MessageUI



class SendMailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    
    @IBOutlet weak var subject: UITextField!
    
    @IBOutlet weak var body: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func sendMailPressed(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail(){
            var subjectText = subject.text
            var bodyText = body.text
            
            var toRecipients = ["sanjay.shrestha010@gmail.com"]
            
            var mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(subjectText!)
            mc.setMessageBody(bodyText, isHTML: false)
            mc.setToRecipients(toRecipients)
            
            self.presentViewController(mc, animated: true, completion: nil)
        }
        else{
            print("No email service")
        }
        
        
        
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
       
        switch result.rawValue{
        case MFMailComposeResultCancelled.rawValue:
            alert("Ooops", msg: "Mail Cancelled")
        case MFMailComposeResultSent.rawValue:
            alert("Yes!", msg: "Mail Sent!")
        case MFMailComposeResultSaved.rawValue:
            alert("Yes!", msg: "Mail Saved!")
        case MFMailComposeResultFailed.rawValue:
            alert("Ooops", msg: "Mail Failed!")
        
        default: break

        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
      //
    }
    
    func alert(title: String, msg: String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: title, style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
 

}
