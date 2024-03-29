//
//  OffersVC.swift
//  projectV5
//
//  Created by Mohamed Samir on 10/5/19.
//  Copyright © 2019 Mohamed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class OffersVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var offers: [Offers]?
    @IBOutlet weak var offersTV: TaTableViewCorners!
    override func viewDidLoad() {
        super.viewDidLoad()
        offers = [Offers]()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOffers()
    }
    
    func getOffers(){
        DispatchQueue.main.async {
            let url = "http://delivery.cloudtouch-test.com/api/products/provider/1?brand=&st=ar&page=1"
            //let parameter = ["brand":"","st":"ar","page":"1"]
            API.get(url:url , parameter: nil, headers: nil) { (check, Respons: [Offers]?) in
                guard let response = Respons else { return }
                self.offers = response
                self.offersTV.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if offers?.count == 0 {
            return 10
        }else{
            return offers!.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT / 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersCell", for: indexPath) as! OffersCell
            if offers?.count != 0 {
                let localOffers = offers?[indexPath.row]
                ////// for get image from the internet using kingFisher
                var stringImage = String(describing: localOffers?.image ?? "")
                if stringImage.contains(" ") {
                    stringImage = stringImage.replacingOccurrences(of: " ", with: "%20")
                }
                if stringImage != "" {
                    let url = URL(string: stringImage)
                    cell.mealImage.kf.indicatorType = .activity
                    cell.mealImage.kf.setImage(with: url, placeholder: UIImage(named: "map"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
                }
            }else{
                cell.mealImage.image = #imageLiteral(resourceName: "burger_male")
        }
        //////
        return cell
    }
}

