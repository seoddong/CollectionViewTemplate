//
//  SettingsViewController.swift
//  MathAvengers
//
//  Created by SeoDongHee on 2016. 7. 1..
//  Copyright © 2016년 SeoDongHee. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    var cellLabel: UILabel?
    var textField: UITextField?
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    let reuseIdentifier = "reuseIdentifier"
    let cells = ["label", "textField", "image", "label", "textField", "image", "label", "textField", "image", "label", "textField", "image"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    
    func setupUI() {
        
        //  Navi Bar
        self.title = "Math Avengers - Settings"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전 단계로", style: .Plain, target: self, action: #selector(self.leftBarButtonPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음 단계로", style: .Plain, target: self, action: #selector(self.nextButtonPressed))
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.yellowColor()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.registerClass(ImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let viewsDictionary = ["collectionView": collectionView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[collectionView]-20-|",
            options: .AlignAllCenterX, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\((self.navigationController?.navigationBar.frame.size.height)! + 40)-[collectionView]-20-|",
            options: .AlignAllCenterY, metrics: nil, views: viewsDictionary))
        
    }
    
    func leftBarButtonPressed() {
        
    }
    
    func nextButtonPressed() {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.nextButtonPressed()
        return true
    }
}


extension SettingsViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImageViewCell
        switch cells[indexPath.row] {
        case "label":
            if let label = cell.cellLabel {
                label.text = "nnname"
                label.hidden = false
            }
            else {
                
                cell.cellLabel = UILabel(frame: cell.frame)
                cell.addSubview(cell.cellLabel!)
                cell.cellLabel?.hidden = false
                cell.cellLabel?.text = "name"
            }
            cell.textField?.hidden = true
            cell.imageView?.hidden = true
            break
        case "textField":
            if let tf = cell.textField {
                tf.text = "008"
                tf.hidden = false
            }
            else {
                
                cell.textField = UITextField(frame: cell.frame)
                cell.addSubview(cell.textField!)
                cell.textField?.hidden = false
                cell.textField?.text = "007"
            }
            cell.cellLabel?.hidden = true
            cell.imageView?.hidden = true
            break
        case "image":
            if let img = cell.imageView {
                img.hidden = false
            }
            else {
                
                cell.imageView = UIImageView(image: UIImage(named: "next"))
                cell.addSubview(cell.imageView!)
                cell.imageView?.hidden = false
            }
            cell.textField?.hidden = true
            cell.cellLabel?.hidden = true
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.greenColor()
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(400, 200)
    }
}
