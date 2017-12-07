//
//  PredictableError.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import Foundation

func predictableError(_ reason: String) -> Error {
    return NSError(
        domain: "io.op.predictable",
        code: 404,
        userInfo: [NSLocalizedDescriptionKey: reason]
    )
}
