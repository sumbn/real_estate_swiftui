
//
//  Created by daktech on 5/15/23.
//

import Foundation

protocol AuthServiceProtocol {
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void)
}
