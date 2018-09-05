//
//  Source.swift
//  IDOneSignal
//
//  Created by Omid Golparvar on 9/5/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIDeviceComplete

public class IDOneSignal {
	
	public typealias RoutesType		= (
		addDevice: String,
		editDevice: String
	)
	
	private static var BaseURL		: String		= ""
	private static var AppID		: String		= ""
	private static var Routes		: RoutesType	= ("", "")
	
	public static var IsConfigured	: Bool			= false
	public static var IsSubscribed	: Bool			= false
	public static var PlayerID		: String?		= nil
	
	public static func Setup(baseURL: String, appID: String, routes: RoutesType = ("onesignal/adddevice", "onesignal/editdevice")) {
		var errors: [IDOneSignalConfigureError] = []
		
		if baseURL.isTrimmedAndEmpty {
			errors.append(.missingBaseURL)
		}
		if appID.isTrimmedAndEmpty {
			errors.append(.missingAppID)
		}
		if (routes.addDevice.isTrimmedAndEmpty || routes.editDevice.isTrimmedAndEmpty) {
			errors.append(.routesMissing)
		}
		
		guard errors.isEmpty else {
			print(IDOneSignalConfigureError.multiple(errors).description)
			return
		}
		
		BaseURL			= baseURL
		AppID			= appID
		Routes			= routes
		IsConfigured	= true
	}
	
	public static func Perform(action: IDOneSignalAction, then callback: @escaping (IDOneSignalActionError?, Any?) -> Void) {
		guard IsConfigured else {
			let error = IDOneSignalActionError.isNotConfigured
			print(error.description)
			callback(error, nil)
			return
		}
		
		do {
			try action.validateBeforePerform()
		} catch {
			let e = error as! IDOneSignalActionError
			print(e.description)
			callback(e, nil)
			return
		}
		
		let url = action.getURL()
		let parameters = action.getParameters()
		
		Alamofire
			.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
			.responseJSON { response in
				
				switch response.result {
				case .success(let data):
					let jsonObject = JSON(data)
					
					if	let httpStatusCode = response.response?.statusCode, httpStatusCode == 200,
						let statusValue = jsonObject["status"].int, statusValue == 1 {
						switch action {
						case .addDevice(_):
							if let playerID = jsonObject["player_id"].string {
								IDOneSignal.PlayerID = playerID
								callback(nil, data)
							} else {
								callback(.invalidResponse, data)
							}
						default:
							callback(nil, data)
						}
					} else {
						callback(.invalidResponse, data)
					}
					
				case .failure(let error):
					print("🆔 ⚠️ - Alamofire request failed: ")
					print(error.localizedDescription)
					print()
					
					callback(.custom(message: error.localizedDescription), nil)
				}
		}
		
	}
	
	public enum IDOneSignalConfigureError: Error, CustomStringConvertible {
		case multiple([IDOneSignalConfigureError])
		
		case missingBaseURL
		case missingAppID
		case requestFailed
		case routesMissing
		case missingPlayerID
		
		public var description: String {
			let _0 = "🆔 ⚠️ - Configuration Error: "
			switch self {
			case .multiple(let errors)	: return _0 + "\n" + errors.map({ $0.description.replacingOccurrences(of: _0, with: " - ") }).joined(separator: "") + "\n"
			case .missingBaseURL		: return _0 + "BaseURL is missing." + "\n"
			case .missingAppID			: return _0 + "AppID is missing." + "\n"
			case .requestFailed			: return _0 + "Request failed." + "\n"
			case .routesMissing			: return _0 + "Route(s) is(are) empty." + "\n"
			case .missingPlayerID		: return _0 + "PlayerID is missing." + "\n"
			}
		}
		
	}
	
	public enum IDOneSignalAction {
		case addDevice(token: String)
		case subscribe
		case unsubscribe
		case setTags(tags: [String: Any])
		
		func getParameters() -> [String: Any] {
			var parameter: [String: Any] = [:]
			parameter["app_id"]			= AppID
			parameter["device_type"]	= 0
			parameter["game_version"]	= Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
			parameter["device_model"]	= UIDevice.current.dc.deviceModel
			parameter["device_os"]		= UIDevice.current.systemVersion
			
			switch self {
			case .addDevice(let token):
				parameter["identifier"]			= token
				parameter["notification_types"]	= 1
			case .subscribe:
				parameter["player_id"]			= IDOneSignal.PlayerID ?? ""
				parameter["notification_types"]	= 1
			case .unsubscribe:
				parameter["player_id"]			= IDOneSignal.PlayerID ?? ""
				parameter["notification_types"]	= -2
			case .setTags(let tags):
				parameter["player_id"]			= IDOneSignal.PlayerID ?? ""
				parameter["notification_types"]	= 1
				parameter["tags"]				= JSON(tags).stringValue
			}
			
			return parameter
		}
		
		func getURL() -> URL {
			switch self {
			case .addDevice(_)	: return URL(string: IDOneSignal.Routes.addDevice)!
			case .subscribe,
				 .unsubscribe,
				 .setTags(_)	: return URL(string: IDOneSignal.Routes.editDevice)!
			}
		}
		
		func validateBeforePerform() throws {
			switch self {
			case .addDevice(let token)	: guard !token.isTrimmedAndEmpty else { throw IDOneSignalActionError.missingDeviceToken }
			case .subscribe,
				 .unsubscribe,
				 .setTags(_)			: guard IDOneSignal.PlayerID != nil else { throw IDOneSignalActionError.missingPlayerID }
			}
		}
	}
	
	public enum IDOneSignalActionError: Error, CustomStringConvertible {
		case missingDeviceToken
		case missingPlayerID
		case isNotConfigured
		case invalidResponse
		case custom(message: String)
		
		public var description: String {
			let _0 = "🆔 ⚠️ - Action Error: "
			switch self {
			case .missingDeviceToken	: return _0 + "APNs token is empty." + "\n"
			case .missingPlayerID		: return _0 + "PlayerID is missing." + "\n"
			case .isNotConfigured		: return _0 + "Framework is NOT configured. Call IDOneSignal.Setup(...)." + "\n"
			case .invalidResponse		: return _0 + "Server response is NOT valid." + "\n"
			case .custom(let message)	: return _0 + "Custom error message: \(message)." + "\n"
			}
		}
	}
}

extension String {
	
	var isTrimmedAndEmpty: Bool { return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
	
}
