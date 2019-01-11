//
//  InvestmentDetailVC.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class InvestmentDetailVC: ViewController {

    //MARK : Arrows
    @IBOutlet weak var ivArrow1: UIImageView!
    @IBOutlet weak var ivArrow2: UIImageView!
    @IBOutlet weak var ivArrow3: UIImageView!
    @IBOutlet weak var ivArrow4: UIImageView!
    @IBOutlet weak var ivArrow5: UIImageView!
    
    //MARK : TableView
    @IBOutlet weak var tableViewMoreInfo: UITableView!
    @IBOutlet weak var tableViewInfo: UITableView!
    @IBOutlet weak var tableViewHeightContraint1: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightContraint2: NSLayoutConstraint!
    
    //MARK : Views
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewLeft: UIView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbFundName: UILabel!
    @IBOutlet weak var lbWhatIs: UILabel!
    @IBOutlet weak var lbDefinition: UILabel!
    @IBOutlet weak var lbRiskTitle: UILabel!
    @IBOutlet weak var lbInfoTitle: UILabel!
    
    var _screenModel = ScreenModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //MARK : Carrega os dados trazidos da API
        self.loadInvestment(){
            //MMARK : muda para thread principal para conseguir alterar a UI
            DispatchQueue.main.async {
                self.bindInvestmentUI()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindInvestmentUI(){
        //MARK : set Outlets
        self.lbTitle.text = self._screenModel.screen?.title ?? ""
        self.lbFundName.text = self._screenModel.screen?.fundName ?? ""
        self.lbWhatIs.text = self._screenModel.screen?.whatIs ?? ""
        self.lbDefinition.text = self._screenModel.screen?.definition ?? ""
        self.lbRiskTitle.text = self._screenModel.screen?.riskTitle ?? ""
        self.lbInfoTitle.text = self._screenModel.screen?.infoTitle ?? ""
        self.setDegreeRisk(risk: self._screenModel.screen?.risk ?? 0)
        
        self.setHeightTableView1()
        self.setHeightTableView2()
        self.tableViewInfo.reloadData()
        self.tableViewMoreInfo.reloadData()
    }
    
    //MARK : Verifica qual é o "risk" e seta o alpha da view como 1, que vai fazer ele aparecer
    func setDegreeRisk(risk : Int64){
        switch risk {
        case 1:
            self.ivArrow1.alpha = 1
        case 2:
            self.ivArrow2.alpha = 1
        case 3:
            self.ivArrow3.alpha = 1
        case 4:
            self.ivArrow4.alpha = 1
        default:
            self.ivArrow5.alpha = 1
        }
    }
    
    func loadInvestment(completion: (() -> Void)? = nil){
        REST.loadScreen(onCompleted: { (responseScreen) in
            print("responseScreen \(responseScreen)")
            self._screenModel = responseScreen
            completion?()
        }) { (responseError) in
            print("responseError \(responseError)")
            completion?()
        }
    }
    
    func bindUI(){
        //MARK : TableView
        self.tableViewMoreInfo.dataSource = self
        self.tableViewMoreInfo.delegate = self
        self.tableViewInfo.dataSource = self
        self.tableViewInfo.delegate = self
        self.tableViewMoreInfo.register(UINib(nibName: "HeaderMoreInfoCell", bundle: nil), forCellReuseIdentifier: "HeaderMoreInfoCell")
        self.tableViewMoreInfo.register(UINib(nibName: "BodyMoreInfoCell", bundle: nil), forCellReuseIdentifier: "BodyMoreInfoCell")
        self.tableViewInfo.register(UINib(nibName: "BodyInfoCell", bundle: nil), forCellReuseIdentifier: "BodyInfoCell")
        
        //MARK : Arredondando os cantos das views
        let path = UIBezierPath(roundedRect:viewLeft.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        viewLeft.layer.mask = maskLayer
        
        let path2 = UIBezierPath(roundedRect:viewRight.bounds,
                                byRoundingCorners:[.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer2 = CAShapeLayer()
        
        maskLayer2.path = path2.cgPath
        viewRight.layer.mask = maskLayer2
    }
    
    //MARK : Ajusta a atura da tabela conforme o tanto de linhas que ela possui
    func setHeightTableView1() {
        self.tableViewMoreInfo.reloadData()
        var tableViewHeight: CGFloat = 0
        
        for i in 0...4 {
            tableViewHeight += self.tableViewMoreInfo.rectForRow(at: IndexPath(row: i, section: 0)).height
        }
        print("PRIMEIRA TABELA ALTURA : \(tableViewHeight)")
        self.tableViewHeightContraint1.constant = tableViewHeight + 40
        self.view.layoutIfNeeded()
    }
    
    func setHeightTableView2() {
        self.tableViewInfo.reloadData()
        var tableViewHeight: CGFloat = 0
        let qtdTableView = (self._screenModel.screen?.info?.count ?? 0) + (self._screenModel.screen?.downInfo?.count ?? 0)
        
        for i in 0...qtdTableView {
            tableViewHeight += self.tableViewInfo.rectForRow(at: IndexPath(row: i, section: 0)).height
            tableViewHeight += self.tableViewInfo.rectForRow(at: IndexPath(row: i, section: 1)).height
        }
        print("ALTURA : \(tableViewHeight)")
        self.tableViewHeightContraint2.constant = tableViewHeight
        self.view.layoutIfNeeded()
    }

    @IBAction func actShare(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func actInvest(_ sender: UIButton) {
    }
    
}

extension InvestmentDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var count:Int?
        
        if tableView == self.tableViewMoreInfo {
            count = 1
        }
        
        if tableView == self.tableViewInfo {
            count = 2
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows : Int = 0
        
        if tableView == self.tableViewMoreInfo {
            rows = 3
        }
        else if tableView == self.tableViewInfo {
            switch section
            {
            case 0:
                rows = (self._screenModel.screen?.info?.count ?? 0)
                
                break
            default:
                rows = (self._screenModel.screen?.downInfo?.count ?? 0)
                break
            }
            //rows = (self._screenModel.screen?.info?.count ?? 0) + (self._screenModel.screen?.downInfo?.count ?? 0)
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableViewInfo {
            return 0
        }
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var cell : UIView?
        
        if tableView == self.tableViewMoreInfo {
            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderMoreInfoCell") as! HeaderMoreInfoCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView == self.tableViewMoreInfo {
            
            if indexPath.row == 0{
                let cellMoreInfo = tableView.dequeueReusableCell(withIdentifier: "BodyMoreInfoCell", for: indexPath) as! BodyMoreInfoCell
                cellMoreInfo.lbName.text = "No mês"
                cellMoreInfo.lbFundPercentage.text = "\(self._screenModel.screen?.moreInfo?.month?.fund ?? 0)"
                cellMoreInfo.lbCDPercentage.text = "\(self._screenModel.screen?.moreInfo?.month?.CDI ?? 0)"
                return cellMoreInfo
            }
            else if indexPath.row == 1{
                let cellMoreInfo = tableView.dequeueReusableCell(withIdentifier: "BodyMoreInfoCell", for: indexPath) as! BodyMoreInfoCell
                cellMoreInfo.lbName.text = "No ano"
                cellMoreInfo.lbFundPercentage.text = "\(self._screenModel.screen?.moreInfo?.year?.fund ?? 0)"
                cellMoreInfo.lbCDPercentage.text = "\(self._screenModel.screen?.moreInfo?.year?.CDI ?? 0)"
                return cellMoreInfo
            }
            else if indexPath.row == 2{
                let cellMoreInfo = tableView.dequeueReusableCell(withIdentifier: "BodyMoreInfoCell", for: indexPath) as! BodyMoreInfoCell
                cellMoreInfo.lbName.text = "12 meses"
                cellMoreInfo.lbFundPercentage.text = "\(self._screenModel.screen?.moreInfo?.the12Months?.fund ?? 0)"
                cellMoreInfo.lbCDPercentage.text = "\(self._screenModel.screen?.moreInfo?.the12Months?.CDI ?? 0)"
                return cellMoreInfo
            }
        }
        
        if tableView == self.tableViewInfo {
            switch indexPath.section
            {
            case 0:
                if (self._screenModel.screen?.info?.indices.contains(indexPath.row))!{
                    let item = self._screenModel.screen?.info![indexPath.row]
                    let cellInfo = tableView.dequeueReusableCell(withIdentifier: "BodyInfoCell", for: indexPath) as! BodyInfoCell
                    cellInfo.lbName.text = item?.name ?? ""
                    cellInfo.lbPercentage.text = item?.data ?? ""
                    cellInfo.lbPercentage.isHidden = false
                    cellInfo.btDownload.isHidden = true
                    return cellInfo
                }
                break
            case 1:
                if (self._screenModel.screen?.downInfo?.indices.contains(indexPath.row))!{
                    let downItem = self._screenModel.screen?.downInfo![indexPath.row]
                    let cellDownInfo = tableView.dequeueReusableCell(withIdentifier: "BodyInfoCell", for: indexPath) as! BodyInfoCell
                    cellDownInfo.lbName.text = downItem?.name ?? ""
                    cellDownInfo.lbPercentage.isHidden = true
                    //MARK : closure usada para acessar a pagina web
                    cellDownInfo.actDownloadNew = {
                        self.openNavegador(_url: "https://www.google.com/")
                    }
                    return cellDownInfo
                }
                break
            default:
                    return cell
                break
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewMoreInfo {
            
        }
        else if tableView == self.tableViewInfo {
            
        }
    }
    
}
