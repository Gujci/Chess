//
//  ReplaceSegue.swift
//  Chess
//
//  Created by Gujgiczer Máté on 2018. 11. 24..
//  Copyright © 2018. gujci. All rights reserved.
//

import UIKit

class ReplaceSegue: UIStoryboardSegue {

    override func perform() { UIApplication.shared.keyWindow?.rootViewController = destination }
}
