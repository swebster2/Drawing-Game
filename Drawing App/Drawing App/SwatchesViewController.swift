//
//  SwatchesViewController.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import UIKit

final class SwatchesViewController: UICollectionViewController {
    private let reuseIdentifier = "SwatchCell";
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    @IBOutlet var MainViewController: UICollectionView!
    
    var containerView = UIView()
    var slideUpView = UITableView()
    let slideUpViewHeight: CGFloat = 200
    
    var currentlySelectedSwatch: IndexPath = []
    
    let slideUpViewDataSource: [Int: (String)] = [
        0: ("Delete it"),
        1: ("Share it")
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.frame = MainViewController.frame
        slideUpView.isScrollEnabled = true
        slideUpView.delegate = self
        slideUpView.dataSource = self
        slideUpView.register(SlideUpViewCell.self, forCellReuseIdentifier: "SlideUpViewCell")
    }
}

extension SwatchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        slideUpViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SlideUpViewCell", for: indexPath) as? SlideUpViewCell
        else {
            fatalError("unable to deque SlideUpViewCell")
        }
        
        cell.labelView.text = slideUpViewDataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            ColorManager.colorCollection.remove(at: currentlySelectedSwatch.row)
            self.MainViewController.deleteItems(at: [currentlySelectedSwatch])
            self.MainViewController.reloadItems(at: self.MainViewController.indexPathsForVisibleItems)
            StorageHandler.set()
            slideUpViewTapped()
        } else if indexPath.row == 1 { //share
            let shareText = "Check out my color: #" + ColorManager.colorCollection[currentlySelectedSwatch.row].GetHex()
            let shareImage = ColorManager.colorCollection[currentlySelectedSwatch.row].GetImage()
            let shareAll = [shareText, shareImage] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

extension SwatchesViewController {
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return StorageHandler.storageCount()
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    // Get the corresponding color
    let cellColorsArray = ColorManager.colorCollection
    let cellColorArray = cellColorsArray[indexPath.item]
    let cellColor = UIColor(red: CGFloat(cellColorArray.red)/255, green: CGFloat(cellColorArray.green)/255, blue: CGFloat(cellColorArray.blue)/255, alpha: CGFloat(cellColorArray.alpha)/255)
    
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    cell.backgroundColor = cellColor
    
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureDetected))
    longPressGesture.minimumPressDuration = 0.5
    longPressGesture.delaysTouchesBegan = true
    cell.addGestureRecognizer(longPressGesture)
    
    return cell
  }
    
    @objc func longPressGestureDetected(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if(gestureRecognizer.state == .began) {
            let point = gestureRecognizer.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point) {
                print(indexPath)
                setupLongPressOverlay(swatchIndex: indexPath)
            } else {
                print("Could not find the path")
            }
        }
    }
    
    func setupLongPressOverlay(swatchIndex: IndexPath) {
        self.currentlySelectedSwatch = swatchIndex
        
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        let screenSize = UIScreen.main.bounds.size
        slideUpView.frame = CGRect(x: 0, y: screenSize.height - (self.tabBarController?.tabBar.frame.size.height)!, width: screenSize.width, height: slideUpViewHeight)
        slideUpView.separatorStyle = .none
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { self.containerView.alpha = 0.75
            self.slideUpView.frame = CGRect(x: 0, y: screenSize.height - self.slideUpViewHeight - (self.tabBarController?.tabBar.frame.size.height)!, width: screenSize.width, height: self.slideUpViewHeight)
        }, completion: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideUpViewTapped))
        containerView.addGestureRecognizer(tapGesture)
        
        
        MainViewController.addSubview(containerView)
        MainViewController.addSubview(slideUpView)
    }
    
    @objc func slideUpViewTapped() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { self.containerView.alpha = 0
            self.slideUpView.frame = CGRect(x: 0, y: screenSize.height - (self.tabBarController?.tabBar.frame.size.height)!, width: screenSize.width, height: self.slideUpViewHeight)
        }, completion: nil)
    }
}

extension SwatchesViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension SwatchesViewController {
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let cellColorsArray = ColorManager.colorCollection
    let cellColorArray = cellColorsArray[indexPath.item]
    let colorTab = tabBarController!.viewControllers![0] as! ViewController

    colorTab.sliderRed.value = Float(cellColorArray.red)
    colorTab.sliderGreen.value = Float(cellColorArray.green)
    colorTab.sliderBlue.value = Float(cellColorArray.blue)
    colorTab.sliderAlpha.value = Float(cellColorArray.alpha)
    colorTab.adjustSlider(self)

    self.tabBarController!.selectedIndex = 0

    return false
  }
}
