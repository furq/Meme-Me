//
//  Meme.swift
//  Meme me v1.0
//
//  Created by Khan, Furqan on 3/8/16.
//  Copyright © 2016 Khan, Furqan. All rights reserved.
//

import Foundation
import UIKit

class Meme {

  var topText: String!
  var bottomText: String!
  var image: UIImage!
  var memedImage: UIImage!

  init(topText: String, bottomText: String, withImage image: UIImage, withMemedImage: UIImage) {
    self.topText = topText
    self.bottomText = bottomText
    self.image = image
    self.memedImage = withMemedImage
  }
}