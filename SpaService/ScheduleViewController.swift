//
//  ScheduleViewController.swift
//  SpaService
//
//  Created by Aparna Revu on 2/13/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

extension UICollectionView {
    func deselectAllItems(_ animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }
}

class ScheduleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    var selectedMassage:[String: String] = [:]
    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var dateCollectionView:UICollectionView?
    @IBOutlet weak var timeCollectionView:UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SCHEDULE"
        
        let leftBarbuttonItem: UIBarButtonItem = UIBarButtonItem(title: "Reserve", style: UIBarButtonItemStyle.plain, target: self, action: #selector(reserveAppointment))
        self.navigationItem.setRightBarButtonItems([leftBarbuttonItem], animated: true)

        
        let collectionViewFlowControl = UICollectionViewFlowLayout()
        collectionViewFlowControl.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionViewFlowControl.minimumInteritemSpacing = 0;
        collectionViewFlowControl.minimumLineSpacing = 0;
        collectionViewFlowControl.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.dateCollectionView = UICollectionView(frame: (self.tableView?.frame)!, collectionViewLayout: collectionViewFlowControl)
        
        self.dateCollectionView?.isPagingEnabled = true
        self.dateCollectionView?.backgroundColor = UIColor.clear
        self.dateCollectionView?.allowsMultipleSelection = false
        
        let collectionViewFlowControl1 = UICollectionViewFlowLayout()
        collectionViewFlowControl1.scrollDirection = UICollectionViewScrollDirection.vertical
        
        collectionViewFlowControl1.minimumInteritemSpacing = 0;
        collectionViewFlowControl1.minimumLineSpacing = 0;
        collectionViewFlowControl1.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)

        self.timeCollectionView = UICollectionView(frame: (self.tableView?.frame)!, collectionViewLayout: collectionViewFlowControl1)
        self.timeCollectionView?.isPagingEnabled = true
        self.timeCollectionView?.backgroundColor = UIColor.clear



        // Do any additional setup after loading the view.
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
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "CellReuseIdentifier" + String(indexPath.row + 1)
        
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifier, for: indexPath)
        if(indexPath.row == 1){
            cell.backgroundColor = UIColor.clear;
        }
        if(indexPath.row == 1){
            dateCollectionView = cell.viewWithTag(1001) as? UICollectionView
            dateCollectionView?.dataSource = self.tableView?.dataSource as! UICollectionViewDataSource?
            dateCollectionView?.delegate = self.tableView?.delegate as! UICollectionViewDelegate?
        }

        if(indexPath.row == 2){
            timeCollectionView = cell.viewWithTag(2001) as? UICollectionView
            timeCollectionView?.dataSource = self.tableView?.dataSource as! UICollectionViewDataSource?
            timeCollectionView?.delegate = self.tableView?.delegate as! UICollectionViewDelegate?
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row == 0){
            return 215
        } else if(indexPath.row == 1){
            return 143
        }

        return 190
    }


    /* COLLECTIONVIEW DATASOURCE METHIDS */
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if (collectionView == self.dateCollectionView){
            return 6
        }
        return 12

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if( collectionView == self.dateCollectionView){
            let CellIdentifier = "DateCollectionCell" + String(indexPath.row + 1)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as? DateCollectionViewCell
            
            cell?.selectedBackgroundView = UIView(frame: (cell?.bounds)!)
            cell?.selectedBackgroundView!.backgroundColor = UIColor.init(colorLiteralRed: 172/255.0, green: 204/255.0, blue: 232/255.0, alpha: 1.0)
            
            return cell!
        }
        let CellIdentifier = "TimeCollectionCell" + String(indexPath.row + 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        cell.selectedBackgroundView = UIView(frame: (cell.bounds))
        cell.selectedBackgroundView!.backgroundColor = UIColor.init(colorLiteralRed: 172/255.0, green: 204/255.0, blue: 232/255.0, alpha: 1.0)

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if( collectionView == self.dateCollectionView){
            return CGSize(width: collectionView.frame.size.width / 5, height: collectionView.frame.size.height)

        }

        return CGSize(width: collectionView.frame.size.width / 3.5, height: 32)

    }
    func reserveAppointment()  {
        //facetime(phoneNumber:"7472506730")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let reserveViewController = storyboard.instantiateViewController(withIdentifier: "ReservationsViewController") as! ReservationsViewController
        self.navigationController?.pushViewController(reserveViewController, animated: true)
    }

    private func facetime(phoneNumber:String) {
        if let facetimeURL:NSURL = NSURL(string: "facetime://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(facetimeURL as URL)) {
                application.open(facetimeURL as URL, options: [:], completionHandler: nil)
            }
        }
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
