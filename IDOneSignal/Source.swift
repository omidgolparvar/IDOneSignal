//
//  Source.swift
//  IDOneSignal
//
//  Created by Omid Golparvar on 9/5/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public class IDOneSignal {
	
	public typealias RoutesType		= (
		addDevice: String,
		editDevice: String
	)
	
	private static var BaseURL		: String		= ""
	private static var AppID		: String		= ""
	private static var Routes		: RoutesType	= (
		addDevice	: "",
		editDevice	: ""
	)
	
	public static var IsConfigured	: Bool		= false
	public static var IsSubscribed	: Bool		= false
	public static var PlayerID		: String?	= nil
	
	private static func CheckConfig() -> IDOneSignalError? {
		guard !BaseURL.isEmpty else { return .missingBaseURL }
		guard !AppID.isEmpty else { return .missingAppID }
		
		return nil
	}
	
	public static func Setup(baseURL: String, appID: String, routes: RoutesType? = nil) throws {
		var errors: [IDOneSignalError] = []
		
		if baseURL.isTrimmedAndEmpty {
			errors.append(.missingBaseURL)
		}
		if appID.isTrimmedAndEmpty {
			errors.append(.missingAppID)
		}
		if let routes = routes, (routes.addDevice.isTrimmedAndEmpty || routes.editDevice.isTrimmedAndEmpty) {
			errors.append(.routesMissing)
		}
		
		guard errors.isEmpty else { throw IDOneSignalError.multiple(errors) }
		
		BaseURL = baseURL
		AppID = appID
		if let routes = routes { Routes = routes }
		IsConfigured = true
	}
	
	public static func AddDevice(with token: String, then callback: @escaping (IDOneSignalError?) -> Void = { _ in }) {
		guard IsConfigured else { callback(.isNotConfigured) ; return }
		
		
	}
	
	public static func Subscribe(then callback: @escaping (IDOneSignalError?) -> Void = { _ in }) {
		guard IsConfigured else { callback(.isNotConfigured) ; return }
		
		
	}
	
	public static func Unsubscribe(then callback: @escaping (IDOneSignalError?) -> Void = { _ in }) {
		guard IsConfigured else { callback(.isNotConfigured) ; return }
		
		
	}
	
	public static func SetTags(_ tags: [(key: String, value: Any)], then callback: @escaping (IDOneSignalError?) -> Void = { _ in }) {
		guard IsConfigured else { callback(.isNotConfigured) ; return }
		
	}
	
	
	
	public enum IDOneSignalError: Error, CustomStringConvertible {
		case multiple([IDOneSignalError])
		
		case isNotConfigured
		case missingBaseURL
		case missingAppID
		case requestFailed
		case routesMissing
		
		public var description: String {
			let _0 = "⚠️ IDOneSingal - Error: "
			switch self {
			case .multiple(let errors)	: return _0 + "\n" + errors.map({ $0.description.replacingOccurrences(of: _0, with: "    - ") }).joined(separator: "\n")
			case .isNotConfigured		: return _0 + "First Of All"
			case .missingBaseURL		: return _0 + "BaseURL Is Missing."
			case .missingAppID			: return _0 + "AppID Is Missing."
			case .requestFailed			: return _0 + "Request Failed."
			case .routesMissing			: return _0 + "Route(s) Is Missing."
			}
		}
		
	}
	
}

extension String {
	
	var isTrimmedAndEmpty: Bool { return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
	
}
