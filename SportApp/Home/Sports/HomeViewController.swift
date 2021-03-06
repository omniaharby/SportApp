//
//  ViewController.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
import Kingfisher

@available(iOS 13.0, *)
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,HomeViewProtcol{
  
    var selectedSport:String?
    
    func gotoSportLeagues(sport:String) {
        // 
    }


    
    func indicator(Status: Bool) {
        if Status {self.indicator.startAnimating()}
        else { self.indicator.stopAnimating()}
    }
    
    func nothingToDisplay(Status: Bool) {
        /////
    }
    
    let  presenter:HomePresenter = HomePresenter(handler: Network.getInstance())
    var indicator = UIActivityIndicatorView(style:.large)
    
    func updateUI() {
         
      
          if presenter.isReachable(){
                 
             SportsCollectionView.reloadData()
             NoConnection.isHidden=true
             
            print(" online!!")
         }
         else {
             indicator(Status: true)
             presenter.SportsList.removeAll()
             NoConnection.isHidden=false
            SportsCollectionView.reloadData()
            if presenter.SportsList.count > 0{
            self.indicator(Status: false)
            }
           print(" offline!!")
        }
          
    }
    
   ////////////////////////////////////////////////////////////
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.SportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let
        sportCell:customCell1=collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! customCell1
           
               
            sportCell.layer.cornerRadius=0
        sportCell.sportImg.kf.setImage(with:URL(string:  presenter.SportsList[indexPath.row].sportsImgPath))
        sportCell.sportName.text=presenter.SportsList[indexPath.row].sportName
               
           return sportCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width=UIScreen.main.bounds.width/2-9
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueView: LeaguesViewController = storyboard?.instantiateViewController(withIdentifier: "LeaguesView") as! LeaguesViewController
        selectedSport=presenter.SportsList[indexPath.row].sportName
        leagueView.sportname=selectedSport
        navigationController?.pushViewController(leagueView, animated: true)
        
        
        
    }
    
///////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        NoConnection.isHidden=true
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        SportsCollectionView.delegate=self
        SportsCollectionView.dataSource=self
        presenter.attachView(view: self)
        presenter.getSportsList()
        updateUI()
        
        
    }
    override func viewDidAppear(_ animated: Bool){
      
      super.viewDidAppear(true)
        indicator(Status: true)
      presenter.getSportsList()
      updateUI()
     
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier=="toLeagues"{
//           var leaguesView:LeaguesViewController=segue.destination as! LeaguesViewController
//                      print("sport segue\(selectedSport)")
//                      leaguesView.sportname=selectedSport
//
//        }
//    }

    @IBOutlet weak var NoConnection: UIImageView!
    @IBOutlet weak var SportsCollectionView: UICollectionView!
}

