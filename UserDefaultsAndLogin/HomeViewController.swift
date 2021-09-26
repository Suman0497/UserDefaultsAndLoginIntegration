//
//  HomeViewController.swift
//  UserDefaultsAndLogin
//
//  Created by apple on 26/09/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    var num = [Int](0...100)
       
       
       let inset: CGFloat = 10
       let minimumLineSpacing: CGFloat = 10
       let minimumInteritemSpacing: CGFloat = 10
       let cellsPerRow = 4
       
       @IBOutlet weak var collectionViewOut: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOut.dataSource = self
        collectionViewOut.delegate = self
        collectionViewOut.contentInsetAdjustmentBehavior = .always
              navigationItem.title = "Welcome"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickLogout(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "email")
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController")
        let navVC = UINavigationController(rootViewController: vc!)
        let share = UIApplication.shared.delegate as? AppDelegate
        share?.window?.rootViewController = navVC
        share?.window?.makeKeyAndVisible()
    }
    

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return num.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let numbers = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? HomeCollectionViewCell {
            numbers.counting(with: String(num[indexPath.row]))
            numbers.backgroundColor = .orange
            cell = numbers
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewOut.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
}
