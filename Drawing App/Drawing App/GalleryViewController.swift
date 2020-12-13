//
//  GalleryViewController.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import Foundation
import UIKit

final class GalleryViewController: UICollectionViewController {
    
    @IBOutlet var galleryView: UICollectionView!
    
    private let reuseIdentifier = "GalleryCell";
}
