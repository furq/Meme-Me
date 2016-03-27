//
//  MemeTableViewController.swift
//  Meme me v1.0
//
//  Created by Khan, Furqan | Furqan | ISDOD on 3/23/16.
//  Copyright © 2016 Khan, Furqan. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

  var memes: [Meme]!

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)

    //` retrieve the saved memes from AppDelegate
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate

    memes = appDelegate.memes

  }

  override func viewDidAppear(animated: Bool) {
    tableView.reloadData()
  }

  /* Number of rows to be displayed */

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }

  /* Display a meme image for each row */
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell")! as UITableViewCell

    let meme = memes[indexPath.row]

    cell.imageView?.image = meme.memedImage
    cell.textLabel?.text = "\(meme.topText) .. \(meme.bottomText)"

    return cell

  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let memeDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    memeDetailVC.detailMeme = memes[indexPath.row]
    navigationController!.pushViewController(memeDetailVC, animated: true)
  }


  @IBAction func addNewMeme(sender: AnyObject) {
    let memeEditorVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController

    presentViewController(memeEditorVC, animated: true, completion: nil)
  }
}
