//
//  MemeCollectionViewController.swift
//  Meme me v1.0
//
//  Created by Khan, Furqan | Furqan | ISDOD on 3/23/16.
//  Copyright © 2016 Khan, Furqan. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  var memes: [Meme]!

  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    memes = appDelegate.memes
    collectionView?.reloadData()

  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let space: CGFloat = 3.0
    let dimension = (view.frame.size.width - (2 * space)) / 3.0
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSizeMake(dimension, dimension)
    memes = appDelegate.memes

  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell

    // retrieve the corresponding meme
    let meme = memes[indexPath.item]
    cell.memeImageView?.image = meme.memedImage
    return cell
  }

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    let memeDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    memeDetailVC.detailMeme = memes[indexPath.row]
    navigationController!.pushViewController(memeDetailVC, animated: true)
  }


  @IBAction func addNewMeme(sender: AnyObject) {
    let memeEditorVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
    presentViewController(memeEditorVC, animated: true, completion: nil)
  }
  
}