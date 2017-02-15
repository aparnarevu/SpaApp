//
//  SpaViewController.swift
//  SpaService
//
//  Created by Aparna Revu on 2/12/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

class SpaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var collectionView : UICollectionView?
    @IBOutlet weak var pageControl : UIPageControl?
    var spaNotificationsList:[[String:String]] = []
    var massagesTypeList:Array<String> = []
    var pageControlIsChangingPage:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

        self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
        
        massagesTypeList = ["Swedish Massage","Deep Tissue Massage","Sport Massage","Reflexology","Trigger Point Therapy"]
        
        loadMassageNotificationDetails()

        let collectionViewFlowControl = UICollectionViewFlowLayout()
        collectionViewFlowControl.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionViewFlowControl.minimumInteritemSpacing = 0;
        collectionViewFlowControl.minimumLineSpacing = 0;
        collectionViewFlowControl.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.collectionView?.collectionViewLayout = collectionViewFlowControl
        self.collectionView?.isPagingEnabled = true
        self.pageControl?.size(forNumberOfPages: 10)
        self.pageControl?.currentPage = 0
        pageControlIsChangingPage = false
        
        self.collectionView?.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massagesTypeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)
        
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = massagesTypeList[indexPath.row]

        if(indexPath.row == 0 || indexPath.row == 4){
            cell.layer.cornerRadius = 5.0
        }

        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    

    /* COLLECTIONVIEW DATASOURCE METHIDS */
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.spaNotificationsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SpaCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? SpaCollectionViewCell)!
        
        let notificationsDict = spaNotificationsList[indexPath.row]
        
        cell.spaTypeTitleLabel?.text = notificationsDict["massageType"]
        cell.availableTimeLabel?.text = notificationsDict["availability"]
        cell.discountLabel?.text = notificationsDict["massageDiscount"]
        cell.reserveButton?.isEnabled = (notificationsDict["isAvailable"] == "yes" ) ? true : false
        
        cell.reserveButton?.addTarget(self, action: #selector(addReservation), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageWidth:CGFloat = scrollView.frame.size.width;
        let count = self.spaNotificationsList.count

        let page = Int((scrollView.contentOffset.x - pageWidth / CGFloat(count)) / pageWidth);
        
        self.pageControl?.currentPage = page + 1
        changePage(self.pageControl ?? self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return (self.collectionView?.frame.size)!
    }

    //Utility Methods
    func loadMassageNotificationDetails()  {
        
        let notificationDict1: [String: String] = ["massageDiscount":"50% OFF","massageType":"Mother's Day","availablity":"AVAIALABLE MAY 1 - 16","isAvailable":"no"]
        spaNotificationsList.append(notificationDict1)
        
        let notificationDict2: [String: String] = ["massageDiscount":"20% OFF","massageType":"Hot Stone","availablity":"AVAIALABLE MAY 1 - 16","isAvailable":"yes"]
        spaNotificationsList.append(notificationDict2)
        
        let notificationDict3: [String: String] = ["massageDiscount":"40% OFF","massageType":"Deep Tissue","availablity":"AVAIALABLE MAY 20 - 28","isAvailable":"no"]
        spaNotificationsList.append(notificationDict3)
        
    }
    
    @IBAction func changePage(_ sender: Any) {
        let x = CGFloat((self.pageControl?.currentPage)!) * (self.collectionView?.frame.size.width)!
        self.collectionView?.setContentOffset(CGPoint (x: x, y: 0), animated: true)
        if( self.pageControl?.currentPage == 0){
            self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        }else if( self.pageControl?.currentPage == 1){
            self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "background-hot-stone-massage.jpg")!)
        }else{
            self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "background-deep-tissue-massage.jpg")!)
        }
    }
    
    func addReservation() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scheduleController = storyboard.instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
        
        scheduleController.selectedMassage = spaNotificationsList[1]
        self.navigationController?.pushViewController(scheduleController, animated: true)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
