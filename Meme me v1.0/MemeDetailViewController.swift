//
//  MemeDetailView.swift
//  Meme me v1.0
//
//  Created by Khan, Furqan | Furqan | ISDOD on 3/25/16.
//  Copyright © 2016 Khan, Furqan. All rights reserved.
//

import UIKit

class MemeDetailViewController:UIViewController {

  @IBOutlet weak var detailImageView: UIImageView!
  var detailMeme: Meme!


  override func viewWillAppear(animated: Bool) {
    detailImageView.image = detailMeme.memedImage;
    self.tabBarController?.tabBar.hidden = true
  }

  override func viewWillDisappear(animated: Bool) {
    self.tabBarController?.tabBar.hidden = false
  }
  
}
