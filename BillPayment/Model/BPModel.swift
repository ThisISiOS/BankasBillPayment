//
//
//  Created by Hetal Patel on 04/12/20.
//

import ObjectMapper

class BPModel: Mappable {
    
    required init(){}
    
    required init?(map: Map){
        self.mapping(map: map)
    }
    
    func mapping(map: Map){
    }
}
