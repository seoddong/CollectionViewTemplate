//
//  SettingsViewController.swift
//  MathAvengers
//
//  Created by SeoDongHee on 2016. 7. 1..
//  Copyright © 2016년 SeoDongHee. All rights reserved.
//

import UIKit

class SupplementaryView: UICollectionReusableView {
    var imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsCell: UICollectionViewCell {
    var imageView = UIImageView()
    var cellLabel = UILabel()
    var textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsViewController: UIViewController {
    
    let uidesign = UIDesign()
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    let reuseIdentifier = "reuseIdentifier"
    let headerIdentifier = "headerIdentifier"
    let sections = ["image", "image"]
    let cells = ["label", "textField", "image", "label", "textField", "image", "label", "textField", "image", "label", "textField", "image"]

    var collectionViewWidth: CGFloat = 0
    
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
        
        layout.scrollDirection = .Vertical
        layout.headerReferenceSize = (UIImage(named: "name")?.size)!
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsZero
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.yellowColor()
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.registerClass(SettingsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.registerClass(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        collectionViewWidth = collectionView.frame.size.width
        
        let viewsDictionary = ["collectionView": collectionView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|",
            options: .AlignAllCenterX, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|",
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
        return sections.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SettingsCell

        switch cells[indexPath.row] {
        case "label":

            //cell.cellLabel.hidden = false
            cell.cellLabel.frame = cell.contentView.frame
            cell.cellLabel.text = "이름을 적어주세요.\(indexPath.row)"
            uidesign.setLabelLayout(cell.cellLabel, fontsize: 40)

            break
            
        case "textField":

            cell.textField.frame = cell.contentView.frame
            cell.textField.text = "007_\(indexPath.row)"
            uidesign.setTextFieldLayout(cell.textField, fontsize: 40)

            break
            
        case "image":

            cell.imageView.frame = cell.contentView.frame
            cell.imageView.image = UIImage(named: "next")
            cell.imageView.contentMode = .ScaleAspectFit

            break
            
        default:
            debugPrint("default")
            break
        }
        return cell
    }
    
    // 섹션 헤더 설정
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var headerView: SupplementaryView?
        if (kind == UICollectionElementKindSectionHeader) {
            headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath) as? SupplementaryView
            let image = indexPath.row % 2 == 0 ? UIImage(named: "name") : UIImage(named: "age")
            headerView?.imageView.image = image
            headerView?.imageView.contentMode = .ScaleAspectFit
            headerView?.imageView.frame = CGRectMake(0, 0, collectionViewWidth, image!.size.height)
            headerView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        }
        return headerView!
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! SettingsCell
        
        switch cells[indexPath.row] {
        case "label":
            cell.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            cell.cellLabel.hidden = false
            cell.imageView.hidden = true
            cell.textField.hidden = true
            break
            
        case "textField":
            cell.backgroundColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5)
            cell.textField.hidden = false
            cell.cellLabel.hidden = true
            cell.imageView.hidden = true
            break
            
        case "image":
            cell.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 0.5)
            cell.imageView.hidden = false
            cell.cellLabel.hidden = true
            cell.textField.hidden = true
            break
            
        default:
            break
            
        }
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        switch cells[indexPath.row] {
        case "label":
            return CGSizeMake(collectionViewWidth, 200)

        case "image":
            //let img = UIImage(named: "next")
            return CGSizeMake(collectionViewWidth, 200) //(img?.size.height)!)

        case "textField":
            return CGSizeMake(collectionViewWidth-200, 100)
            
        default:
            return CGSizeMake(collectionViewWidth, 200)

        }
    }
}
