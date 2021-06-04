//
//  Profile.swift
//  RandomAPI
//
//  Created by administrador on 14/5/21.
//

import UIKit

@IBDesignable
class Profile: UIView {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblSentence: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet var btnSelect: [UIButton]!
    
    let userNetworking: UserNetworking = UserNetworking()
    var user: User? = nil
    override init(frame: CGRect){
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.loadView()
    }
    
    func loadView() {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    
    func showData() {
        userNetworking.getUser { user in
            self.user = user
            let imageUrl:URL = user.picture.medium
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imgProfile.image = image
                    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width/2.0
                }
                
            }
        }
    }
    
    
    
    
    @IBAction func showName(_ sender: UIButton) {
        self.lblSentence.text = "Hi, My name is"
        self.lblData.text = user?.name.first
        btnSelect.forEach { btn in
            btn.tintColor = .black
        }
        sender.tintColor = UIColor.green
    }
    
    @IBAction func showEmail(_ sender: UIButton) {
        self.lblSentence.text = "My email address is"
        self.lblData.text = user?.email
        btnSelect.forEach { btn in
            btn.tintColor = .black
        }
        sender.tintColor = UIColor.green
        
    }
    
    @IBAction func showDate(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        
        var date: Date
        var strDate: String
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        strDate = user?.dob.date ?? "" // Coge bien el valor del json
        date = dateFormatter.date(from: strDate) ?? Date() // Pone la fecha actual. No convierte bien la información
        
        self.lblSentence.text = "My birhday is"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.lblData.text = dateFormatter.string(from: date)
        btnSelect.forEach { btn in
            btn.tintColor = .black
        }
        sender.tintColor = UIColor.green
        
        
    }
    
    @IBAction func showLocation(_ sender: UIButton) {
        self.lblSentence.text = "My address is"
        self.lblData.text = String(user?.location.street.number ?? 0)  + " " + (user?.location.street.name ?? " ")
        btnSelect.forEach { btn in
            btn.tintColor = .black
        }
        sender.tintColor = UIColor.green
        
        
    }
    
    @IBAction func showPhone(_ sender: UIButton) {
        self.lblSentence.text = "My phone number is"
        self.lblData.text = user?.phone
        btnSelect.forEach { btn in
            btn.tintColor = .black
        }
        sender.tintColor = UIColor.green
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        self.lblSentence.text = "My password is"
        self.lblData.text = user?.login.password
        btnSelect.forEach { btn in
            btn.tintColor = .black
        }
        sender.tintColor = UIColor.green
    }
}
