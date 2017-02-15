//
//  ReservationsViewController.swift
//  SpaService
//
//  Created by Aparna Revu on 2/13/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

class ReservationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var headerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView?.tableFooterView = UIView.init(frame: CGRect.zero)
        let rightBarbuttonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (addNewAppointment))
        self.navigationItem.setRightBarButtonItems([rightBarbuttonItem], animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)
        
        return cell
    }
    

    func addNewAppointment()   {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let reserveViewController = storyboard.instantiateViewController(withIdentifier: "ReservationsViewController") as! ReservationsViewController
        self.navigationController?.pushViewController(reserveViewController, animated: true)

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
