//
//  IgrantAgentOrgDetailViewController.swift
//  Alamofire
//
//  Created by Mohamed Rebin on 21/12/20.
//

import UIKit

class IgrantAgentOrgDetailViewController: AriesBaseViewController {

    @IBOutlet weak var orgTableView: UITableView!
    @IBOutlet weak var navTitleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet var topConstraint : NSLayoutConstraint!
    @IBOutlet var topBarItemConstraint : NSLayoutConstraint!
    var overViewCollpased = true
//    var cellHeights = [IndexPath: CGFloat]()
    var viewModel : IgrantAgentOrgDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setupUI()
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Constants.didRecieveCertOffer, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func fetchData() {
        viewModel?.fetchCertificates(completion: { [unowned self] (success) in
            self.orgTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
        
    @IBAction func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func localizableValues() {
        super.localizableValues()
        self.title = "".localized()
        self.orgTableView.reloadData()
    }
    
    func setupUI(){
        if UIDevice.current.hasNotch {
            topConstraint.constant = -45.0
            topBarItemConstraint.constant = -15.0
        }
        orgTableView.estimatedRowHeight = 40
        self.orgTableView.rowHeight = UITableView.automaticDimension
        orgTableView.tableFooterView = UIView()
        backBtn.layer.cornerRadius =  backBtn.frame.size.height/2
        moreBtn.layer.cornerRadius =  moreBtn.frame.size.height/2
    }
    
    deinit {
        print("OrgDetail obj removed from memory")
    }

}

extension IgrantAgentOrgDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if !(viewModel?.isiGrantOrg ?? false) {
                return 1
            }
            return 2
        } else if section == 1 {
            return (viewModel?.orgCertListModel?.dataCertificateTypes?.count ?? 0 == 0) ? 1 :  viewModel?.orgCertListModel?.dataCertificateTypes?.count ?? 0
        }
        else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.section == 0{
            if indexPath.row == 0{
                return 235
            }else{
                return UITableView.automaticDimension
            }
        } else if indexPath.section == 1 {
            if viewModel?.orgCertListModel?.dataCertificateTypes?.count ?? 0 == 0 {
                return 150
            }
            return UITableView.automaticDimension
        }
        else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section == 0{
            if indexPath.row == 0{
                let orgCell = tableView.dequeueReusableCell(withIdentifier:"OrgImageTableViewCell",for: indexPath) as! OrgImageTableViewCell
                orgCell.nameLbl.text = viewModel?.orgInfo?.name ?? (viewModel?.connectionModel?.value?.theirLabel ?? "")
                orgCell.locationLbl.text = viewModel?.orgInfo?.location ?? ""
                UIApplicationUtils.shared.setRemoteImageOn(orgCell.logoImageView, url: viewModel?.orgInfo?.logoImageURL ?? (viewModel?.connectionModel?.value?.imageURL ?? ""))
                UIApplicationUtils.shared.setRemoteImageOn(orgCell.orgImageView, url: viewModel?.orgInfo?.coverImageURL ?? (viewModel?.connectionModel?.value?.orgDetails?.coverImageURL ?? ""),placeholderImage: #imageLiteral(resourceName: "00_Default_CoverImage_02-min"))
                return orgCell
            }else{
                let orgOverViewCell = tableView.dequeueReusableCell(withIdentifier:"OrgOverViewTableViewCell",for: indexPath) as! OrgOverViewTableViewCell
                
                orgOverViewCell.overViewLbl.delegate = self
                orgOverViewCell.layoutIfNeeded()
                orgOverViewCell.overViewLbl.shouldCollapse = true
//                if viewModel?.orgCertListModel?.dataCertificateTypes?.count ?? 0 < 2 {
//                    orgOverViewCell.dataHeader.isHidden = true
//                } else {
//                    orgOverViewCell.dataHeader.isHidden = false
//                }
                if overViewCollpased == true{
//                    orgOverViewCell.overViewLbl.collapsed = overViewCollpased
//                    orgOverViewCell.overViewLbl.numberOfLines = 3
                    orgOverViewCell.overViewLbl.collapsed = true

                }else{
                    orgOverViewCell.overViewLbl.collapsed = false
//                    orgOverViewCell.overViewLbl.numberOfLines = 0
                }
                orgOverViewCell.overViewLbl.textReplacementType = .word
                if let desc = viewModel?.orgInfo?.organisationInfoModelDescription ?? (viewModel?.connectionModel?.value?.orgDetails?.organisationInfoModelDescription){
                    orgOverViewCell.overViewLbl.text = desc
//                    orgOverViewCell.overViewLbl.setHTMLFromString(text: "Aksjdh khaksjdh ksa dkhksadh  khadkjhsa kd kahsdkjashd kah dskh sakdh \n askdh kasd kadkhsakjdh ksajhd  kahsdkhsakjdhksa hdksha kdhaskj d \n \n akdhskjdhkasdh kasdhkjashdkjhsa dkashdkjsad ksahdkjashd ksa hdksa ksahdkjsahdkjsahdkjhsakjdhkasjhdkjsahd ksajhdksah dkhsakjdh ksajdksah dksadkhskajhd kjsahdkshakd h kashdk\n dashgdashgdgsadggasdgj")
//                    orgOverViewCell.overViewLbl.text = "Aksjdh khaksjdh ksa dkhksadh  khadkjhsa kd kahsdkjashd kah dskh sakdh \n askdh kasd kadkhsakjdh ksajhd  kahsdkhsakjdhksa hdksha kdhaskj d \n \n akdhskjdhkasdh kasdhkjashdkjhsa dkashdkjsad ksahdkjashd ksa hdksa ksahdkjsahdkjsahdkjhsakjdhkasjhdkjsahd ksajhdksah dkhsakjdh ksajdksah dksadkhskajhd kjsahdkshakd h kashdk\n dashgdashgdgsadggasdgj"
                    //                    cell.descriptionLbl.from(html: desc)
                }
                return orgOverViewCell
            }
        } else if indexPath.section == 1 {
        
        if viewModel?.orgCertListModel?.dataCertificateTypes?.count == 0 {
            let cell = UITableViewCell()
            let height = 100
            let iconHeight: CGFloat = 40.0
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 100))
            let messageLabel = UILabel.init(frame: CGRect.init(x: 0, y: (CGFloat(height/2) - iconHeight/2) + iconHeight + 5, width: tableView.frame.width, height: 40))
            messageLabel.text = "No data available".localized()
            messageLabel.textColor = .darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
            
            let noDataIcon = UIImageView.init(frame: CGRect.init(x: 0, y: CGFloat(height/2) - iconHeight/2, width:  tableView.frame.width, height: iconHeight))
            noDataIcon.image = UIImage.init(named: "ic_block", in: UIApplicationUtils.shared.getResourcesBundle(), compatibleWith: nil)
            noDataIcon.contentMode = .scaleAspectFit
            
            view.addSubview(noDataIcon)
            view.addSubview(messageLabel)
            cell.addSubview(view)
            cell.selectionStyle = .none
            if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width , bottom: 0, right: 0)
            }
            cell.backgroundColor = .clear
            return cell
        }
        let cell:CertificateWithDataTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CertificateWithDataTableViewCell") as? CertificateWithDataTableViewCell
        let item = viewModel?.orgCertListModel?.dataCertificateTypes?[indexPath.row]
        cell?.certData = item?.attrArray ?? []
        cell?.certName.text = item?.schemaName?.uppercased() ?? ""
        cell?.showValues = false
        if item?.offerAvailable ?? false {
            cell?.addButton.isHidden = false
            cell?.addButton.addTarget(self, action: #selector(clickedOnAddCert(sender:)), for: .touchUpInside)
        } else {
            cell?.addButton.isHidden = true
        }
        cell?.selectionStyle = .none
        if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
            cell?.separatorInset = UIEdgeInsets(top: 0, left: cell?.bounds.size.width ?? 0, bottom: 0, right: 0)
        }
        cell?.layoutIfNeeded()
        return cell ?? UITableViewCell()
//        let cell = tableView.dequeueReusableCell(withIdentifier:"OrgCredentialsTableViewCell",for: indexPath) as! OrgCredentialsTableViewCell
//        let item = viewModel?.orgCertListModel?.dataCertificateTypes?[indexPath.row]
//        cell.dataName?.text = item?.schemaName ?? "" + (item?.offerAvailable ?? false ? "+" : "")
//        cell.dataVersion.text = "Version : " + (item?.schemaVersion ?? "")
//        cell.shadowView.layer.cornerRadius = 5
//        cell.shadowView.layer.shadowColor = UIColor.lightGray.cgColor
//        cell.shadowView.layer.shadowOpacity = 0.5
//        cell.shadowView.layer.shadowOffset = .zero
//        cell.shadowView.layer.shadowRadius = 5
//        cell.addCredential.tag = indexPath.row
//        if item?.offerAvailable ?? false{
//            cell.addCredential.isHidden = false
//            cell.addCredential.addTarget(self, action: #selector(clickedOnAddCert(sender:)), for: .touchUpInside)
//        } else {
//            cell.addCredential.isHidden = true
//        }
//        cell.selectionStyle = .none
//        return cell
        } else {
            let cell:WalletDetailDeleteTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "WalletDetailDeleteTableViewCell") as? WalletDetailDeleteTableViewCell
            cell?.selectionStyle = .none
            if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
                cell?.separatorInset = UIEdgeInsets(top: 0, left: cell?.bounds.size.width ?? 0, bottom: 0, right: 0)
            }
            cell?.name.text = "Remove Organisation".localized()
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 { //delete
            let alert = UIAlertController(title: "Alert", message: "Do you want to remove the organisation?".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes".localized(), style: .destructive, handler: { [self] action in
                self.viewModel?.deleteOrg()
                alert.dismiss(animated: true, completion: nil)
                  }))
            alert.addAction(UIAlertAction(title: "No".localized(), style: .cancel, handler: { action in
                alert.dismiss(animated: true, completion: nil)
                  }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func clickedOnAddCert(sender: UIButton){
        let cert = viewModel?.orgCertListModel?.dataCertificateTypes?[sender.tag]
        if let controller = UIStoryboard(name:"igrant-datawallet", bundle:UIApplicationUtils.shared.getResourcesBundle()).instantiateViewController( withIdentifier: "CertificatePreviewViewController") as? CertificatePreviewViewController {
            controller.viewModel = CertificatePreviewViewModel.init(walletHandle: viewModel?.walletHandle, reqId: viewModel?.reqId ?? "", certDetail: cert?.certificates?.value?.offerCredential, inboxId: cert?.certificates?.id)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension IgrantAgentOrgDetailViewController: ExpandableLabelDelegate{
    func willExpandLabel(_ label: ExpandableLabel){
        overViewCollpased = false
        self.orgTableView.reloadData()
    }
    
    func didExpandLabel(_ label: ExpandableLabel){
        
    }
    
    func willCollapseLabel(_ label: ExpandableLabel){
        
    }
    
    func didCollapseLabel(_ label: ExpandableLabel){
        overViewCollpased = true
        self.orgTableView.reloadData()
    }
}

extension IgrantAgentOrgDetailViewController: IgrantAgentOrgDetailViewModelDelegate {
    func goBack() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Constants.reloadOrgList, object: nil)
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.removeObserver(self)
        }
    }
}
