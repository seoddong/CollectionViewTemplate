# KeyboardExtension.swift  

    //
    //  KeyboardExtension.swift
    //  CollectionViewTemplate
    //
    //  Created by SeoDongHee on 2016. 7. 5..
    //  Copyright © 2016년 SeoDongHee. All rights reserved.
    //
    //  이 키보드 확장을 제대로 사용하기 위해서는 다음 단계로 세팅이 필요하다.
    //  1. 본 클래스에 변수 설정
    //     var keyboardYN = false
    //     var rectKeyboard: CGRect!
    //  2. 본 클래스의 viewDidLoad에 키보드 이벤트 등록
    //     self.performSelector(#selector(registerKeyboardEvent))
    //  3. 본 클래스의 viewDidDisappear에 키보드 이벤트 해제
    //     self.performSelector(#selector(unregisterKeyboardEvent))
    //  4. 본 클래스에 activeField 변수 추가
    //  5. dismiss keyboard를 위한 본 클래스의 viewDidLoad에 UITapGestureRecognizer 코드 추가
    //
    //  키보드에 따른 뷰 처리를 스크롤로 할 것인지 최상위 뷰의 프레임 위치 조정을 통해서 할 것인지 선택이 필요하다.
    //
    import UIKit

    extension SettingsViewController {
        
        //
        // dismiss keyboard를 위해 호출되는 메소드
        // 본 클래스의 viewDidLoad에 아래 두 줄 추가
        // let dismissTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        // self.view.addGestureRecognizer(dismissTap)
        //
        func handleTap() {
            debugPrint("touchesBegan")
            if let af = activeField {
                af.endEditing(true)
            }
        }
        
        // 키보드가 떠오를 때 발생하는 이벤트 처리
        func keyboardWillShow(notification: NSNotification) {
            debugPrint("keyboard will show")
            keyboardYN = true
            let userInfo = notification.userInfo!
            rectKeyboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            
        
            // 스크롤이 가능한 경우
            let collectionViewOffset = self.collectionView.contentOffset
            let activeFieldOrigin = CGPointMake((activeField!.superview?.superview?.frame.origin.x)! - collectionViewOffset.x, (activeField!.superview?.superview?.frame.origin.y)! - collectionViewOffset.y)
            // 키보드에 가려지는 경우에만 화면을 올린다.
            if CGRectContainsPoint(rectKeyboard, activeFieldOrigin) {
                self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y + rectKeyboard.size.height)
            }
            
        }
        
        // 키보드가 사라질 때 발생하는 이벤트 처리
        func keyboardWillHide(notification: NSNotification) {
            debugPrint("keyboard will hide")
            keyboardYN = false
            let userInfo = notification.userInfo!
            rectKeyboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            
            // 스크롤이 가능한 경우
            let collectionViewOffset = self.collectionView.contentOffset
            let activeFieldOrigin = CGPointMake((activeField!.superview?.superview?.frame.origin.x)! - collectionViewOffset.x, (activeField!.superview?.superview?.frame.origin.y)! - collectionViewOffset.y)
            let newRectKeyboard = CGRectMake(rectKeyboard.origin.x, rectKeyboard.origin.y - (rectKeyboard.size.height * 2), rectKeyboard.size.width, rectKeyboard.size.height)
            if CGRectContainsPoint(newRectKeyboard, activeFieldOrigin) {
                self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y - rectKeyboard.size.height)
            }

        }
        
        // 위 두 가지 키보드 이벤트를 이벤트로 등록
        func registerKeyboardEvent() {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        }
        
        // 위 두 가지 키보드 이벤트를 이벤트에서 해제
        func unregisterKeyboardEvent() {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        }
    }

    extension SettingsViewController: UITextFieldDelegate {
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            activeField = nil
            self.nextButtonPressed()
            return true
        }
        
        func textFieldDidBeginEditing(textField: UITextField) {
            debugPrint("textFieldDidBeginEditing")
            activeField = textField
        }
    }
    
