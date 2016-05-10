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
    
    var emailAddress: String?
    // format on how the email is structured.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subject.delegate = self
        print(emailAddress)
        //self.body.delegate = self

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
            let subjectText = subject.text
            let bodyText = body.text
            
            let toRecipients = [self.emailAddress!]
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(subjectText!)
            mc.setMessageBody(bodyText, isHTML: false)
            mc.setToRecipients(toRecipients)
            print("Sending mail")
            
            self.presentViewController(mc, animated: true, completion: nil)
        }
        else{
            print("No email service")
        }
        
    
        // Strings show to whom the email must be sent to and the message that the email contains.
        
        
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
// In case that the message wants to be saved or it wants to be deleted, It shows the reponse messages to each case. 
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
      //
    }
    
    func alert(title: String, msg: String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: title, style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
        if segue.identifier == "showDetailsSegue"{
            
            let destinationVC = segue.destinationViewController as! DetailRideViewController
            // destinationVC.rideDetail = tempArray[indexPath.row] as? Trips
            //vc.detailTrips = tempArray[indexPath.row] as! NSMutableArray
        }
    }
    
    
 

}


extension SendMailViewController: UITextFieldDelegate{
  
    
    func textFieldDidBeginEditing(textField: UITextField) {
       // ScrollView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        subject.resignFirstResponder()
        return true
    }
}
