# Changelog

All notable changes to this project will be documented in this file.

---

## [0.1.0-alpha.5] - 2026-05-26

### Added

- Per-widget rebuild visualization
- Independent widget heatmap overlays
- Local rebuild counters rendered directly on tracked widgets
- Animated rebuild highlight effects
- Granular rebuild tracking demonstration example
- Multi-widget async rebuild showcase for GIF generation

### Changed

- Refactored tracking architecture to use local widget-driven overlays
- `TrackedWidget` migrated from `StatelessWidget` to `StatefulWidget`
- Overlay rendering moved from global rebuild listeners to local widget state
- `PulseOverlay` simplified into lightweight global metrics HUD
- Rebuild visualization now occurs independently per tracked widget

### Improved

- Stability during high-frequency rebuild scenarios
- Runtime instrumentation performance
- Overlay responsiveness during async widget updates
- Scalability for large widget trees and animated lists
- Demo realism for rebuild visualization examples

### Fixed

- Fixed `setState() or markNeedsBuild() called during build`
- Fixed `widget tree was locked` exceptions
- Removed rebuild race conditions caused by global listeners
- Eliminated `AnimatedBuilder` rebuild synchronization issues
- Prevented cascading overlay rebuild loops

---

## [0.1.0-alpha.4] - 2026-05-26

### Fixed

- Fixed GIF rendering on pub.dev README
- Migrated documentation assets to `docs/gifs`
- Replaced relative asset paths with GitHub raw asset URLs for pub.dev compatibility

### Added

- Automated GitHub Actions publish pipeline
- Release workflow triggered via Git tags
- CI validation for formatting, analyze and tests before publishing
- Improved project documentation structure
- Enhanced README visual preview section

### Improved

- README organization and readability
- Open-source project structure
- Documentation consistency
- Release workflow strategy

---

## [0.1.0-alpha.3] - 2026-05-25

### Fixed

- Improved README preview rendering
- Updated documentation asset structure
- Initial fixes for GIF visualization on pub.dev

### Added

- Initial preview GIFs
- Visual demonstration assets
- Documentation media structure

---

## [0.1.0-alpha.2] - 2026-05-25

### Fixed

- Improved README preview rendering
- Updated documentation asset structure
- Initial fixes for GIF visualization on pub.dev

### Added

- Initial preview GIFs
- Visual demonstration assets
- Documentation media structure

---

## [0.1.0-alpha.1] - 2026-05-25

### Added

- Initial alpha release
- Real-time rebuild tracking
- Widget rebuild counters
- Visual debug overlay
- Lightweight runtime instrumentation
- Plug-and-play integration
- Initial tracking architecture
- MIT License
- GitHub Actions CI pipeline
- README documentation
- Project roadmap
- Contribution guidelines
- Initial package structure

### Planned

- Heatmaps
- Frame analysis
- DevTools integration
- Widget tree inspection
- Timeline profiling
- Performance visualization
- Metrics exporting