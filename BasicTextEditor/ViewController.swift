//
//  ViewController.swift
//  BasicTextEditor
//
//  Created by Khusboo Suhasini Preety on 11/09/19.
//  Copyright © 2019 Khusboo Suhasini Preety. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textEditorTxtView: UITextView!
    
    @IBOutlet weak var italicBtn: UIBarButtonItem!
    @IBOutlet weak var boldBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func cancelBtnAction(_ sender: UIBarButtonItem) {
        textEditorTxtView.text = ""
        textEditorTxtView.font = UIFont.SetNormalFnc(textEditorTxtView.font!)()
        italicBtn.tintColor = UIColor.black
        boldBtn.tintColor = UIColor.black
        textEditorTxtView.resignFirstResponder()
    }
    
    
    @IBAction func italicBtnAction(_ sender: Any) {
        if italicBtn.tintColor == UIColor.black {
            italicBtn.tintColor = UIColor.red
            textEditorTxtView.font = UIFont.setItalicFnc(textEditorTxtView.font!)()
        }else{
            italicBtn.tintColor = UIColor.black
            textEditorTxtView.font = UIFont.detItalicFnc(textEditorTxtView.font!)()
        }
    }
    
    @IBAction func addImgTextview(_ sender: Any) {
        
        //create your UIImage
        let image = UIImage(named: "sampleImg");
        //create and NSTextAttachment and add your image to it.
        let attachment = NSTextAttachment()
        attachment.image = image
        let newImageWidth = (textEditorTxtView.bounds.size.width - 20 )
        let scale = newImageWidth/(image?.size.width)!
        let newImageHeight = (image?.size.height)! * scale
        
        //resize attachment
        attachment.bounds = CGRect.init(x: 10, y: 10, width: newImageWidth, height: newImageHeight)
        let attString = NSAttributedString(attachment: attachment)
        textEditorTxtView.textStorage.insert(attString, at: textEditorTxtView.selectedRange.location)
    }
    
    @IBAction func boldBtnAction(_ sender: UIBarButtonItem) {
        if boldBtn.tintColor == UIColor.black {
           boldBtn.tintColor = UIColor.red
           textEditorTxtView.font = UIFont.setBoldFnc(textEditorTxtView.font!)()
        }else{
           boldBtn.tintColor = UIColor.black
           textEditorTxtView.font = UIFont.detBoldFnc(textEditorTxtView.font!)()
        }
    }
    
    @IBAction func saveBtnAction(_ sender: UIBarButtonItem) {
        
        let txtData = Data(textEditorTxtView.text.utf8)
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let fileName = UUID().uuidString
            let filePath = (documentsPath as NSString).appendingPathComponent("\(fileName).pdf")
            let url = URL(fileURLWithPath: filePath)
            do {
              try txtData.write(to: url)
            }
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
        } catch (let error) {
            print("\(error)")
        }
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textEditorTxtView.contentInset = .zero
        } else {
            textEditorTxtView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textEditorTxtView.scrollIndicatorInsets = textEditorTxtView.contentInset
        
        let selectedRange = textEditorTxtView.selectedRange
        textEditorTxtView.scrollRangeToVisible(selectedRange)
    }
}

