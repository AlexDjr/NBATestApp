//
//  ScdAPIResponse.swift
//  NBATestApp
//
//  Created by Alex Delin on 16/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import Foundation

struct SCDAPIResponse : Decodable {
    var lscd : [SCDAPIMonthSCD]
}
