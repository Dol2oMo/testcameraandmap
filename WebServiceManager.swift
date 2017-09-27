//
//  WebServiceManager.swift
//  jsonAlmofire
//
//  Created by MC-MG57035 on 9/12/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit

class WebServiceManager: NSObject ,WebServiceWorkerdelegate {
    
    static let sharedInstance = WebserviceWorker()
    
    //    override init() {
    //        pendingWorker = NSMutableSet()
    //    }
    
    
    
    func workerWithDelegate(delegate_:Any) -> WebserviceWorker {
        
        
        let webservice = WebserviceWorker.init()
        webservice.delegates = self
        webservice.requestClassDelegate = delegate_ as? WebServiceWorkerdelegate
        
        
        //        pendingWorker.add(_:delegate_)
        
        
        return webservice
        
    }
    

}
