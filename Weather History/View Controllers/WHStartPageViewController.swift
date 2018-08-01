//
//  WHStartPageViewController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class WHStartPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        let locationsController = WHLocationTableViewController(nibName: "WHLocationTableViewController", bundle: nil)
        let locationsNavigationController = UINavigationController(rootViewController: locationsController)
        self.present(locationsNavigationController, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
