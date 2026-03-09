//
//   PFWebView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import SwiftUI
import WebKit

/// A web view that loads a URL and shows errors
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct PFWebView: View {
    public let url: URL
    @Environment(\.dismiss) var dismiss

    /// The web page being loaded
    @State private var page: WebPage?

    /// The default web page configuration
    private static var configuration: WebPage.Configuration = {
        var prefs = WebPage.NavigationPreferences()
        prefs.allowsContentJavaScript = true
        prefs.preferredHTTPSNavigationPolicy = .keepAsRequested
        prefs.preferredContentMode = .mobile

        var configuration = WebPage.Configuration()
        configuration.defaultNavigationPreferences = prefs
        configuration.websiteDataStore = .nonPersistent()
        configuration.applicationNameForUserAgent = "\(Bundle.main.bundleName, default: "") \(Bundle.main.versionNumber, default: "")"
        return configuration
    }()

    public var body: some View {
        NavigationStack {
            if let page {
                WebView(page)
                    .webViewContentBackground(.hidden)
                    .ignoresSafeArea(.container, edges: .bottom)
                    .overlay {
                        if page.isLoading {
                            ProgressView()
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                                .background(.black.opacity(0.25))
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel", systemImage: "xmark") {
                                dismiss()
                            }
                        }
                    }
            }
        }
        .background(.clear)
        .onAppear {
            load()
        }
    }

    // MARK: - Private Methods

    /// Loads the page
    private func load() {
        var request = URLRequest(url: url)
        request.attribution = .user

        let page = WebPage(configuration: Self.configuration)
        _ = page.load(request)

        self.page = page

        // Start observing navigations
        Task {
            do {
                for try await event in page.navigations {
                    handleNavigationEvent(event)
                }
            } catch {
                log.error("Web page error: \(error.localizedDescription)")
                loadErrorPage()
            }
        }
    }

    /// Loads the error page from the app bundle
    private func loadErrorPage() {
        let url = Bundle.main.url(forResource: "error", withExtension: "html")
        guard let page, let url else {
            log.error("Error file not found")
            return
        }

        page.load(URLRequest(url: url))
    }

    /// Handle navigation events
    private func handleNavigationEvent(_ event: WebPage.NavigationEvent) {}
}
