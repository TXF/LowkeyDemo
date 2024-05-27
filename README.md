# Lowkey Demo

https://github.com/TXF/LowkeyDemo/assets/4419198/afa33948-0e30-4278-ac73-f7445b292cf7

## Requirements:
### Functional:
- Cell must contain: author's name, shadow and corner radius
- Pagination
- On cell selection show detail page with full image

### Extra
- Dark / Light themes
- Unit tests

### Non-Functional:

- Performance:
  - Caching images.

- Scalability:
  - Modularity.
  
- Reliability:
  - Unit tests.
  
  
## Design Decisions
- UI:
  - SwiftUI
  - MVVM Architecture

- Principals and Patterns:
  - SOLID conformance:
    - Features are separated into modules.
  - Utilizing IoC and DI.
  - Coordinator pattern for navigation.


- Dependency Manager:
  - Swift Package Manager

- Dependencies:
  - [Swinject](https://github.com/Swinject/Swinject): Dependency injection framework.
  - [Kingfisher](https://github.com/onevcat/Kingfisher): Downloading and caching images from the web.
  - [PullToRefreshSwiftUI](https://github.com/YuantongL/SwiftUI-PullToRefresh): PullToRefresh for SwiftUI.
