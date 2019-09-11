//
//  SetFontStyleClass.swift
//  BasicTextEditor
//
//  Created by Khusboo Suhasini Preety on 12/09/19.
//  Copyright © 2019 Khusboo Suhasini Preety. All rights reserved.
//

import UIKit

extension UIFont
{
    var isBold: Bool
    {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool
    {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    func setBoldFnc() -> UIFont
    {
        if(isBold)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func setItalicFnc()-> UIFont
    {
        if(isItalic)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitItalic])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func setBoldItalicFnc()-> UIFont
    {
        return setBoldFnc().setItalicFnc()
    }
    
    func detBoldFnc() -> UIFont
    {
        if(!isBold)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func detItalicFnc()-> UIFont
    {
        if(!isItalic)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitItalic])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func SetNormalFnc()-> UIFont
    {
        return detBoldFnc().detItalicFnc()
    }
    
    func toggleBoldFnc()-> UIFont
    {
        if(isBold)
        {
            return detBoldFnc()
        }
        else
        {
            return setBoldFnc()
        }
    }
    
    func toggleItalicFnc()-> UIFont
    {
        if(isItalic)
        {
            return detItalicFnc()
        }
        else
        {
            return setItalicFnc()
        }
    }
}
