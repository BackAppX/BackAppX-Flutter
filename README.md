## Backappx-Package
BackAppX-Package is a Flutter package for the BackAppX platform.


## Getting started
This package is currently under development. Please use it at your own risk.

## Features
The package provides a simple way to integrate the BackAppX platform into your Flutter app.
It provides the following classes:

• Auth : this class provides a simple way to authenticate clients with the BackAppX platform. <br>
• Product : this class provides a simple way to manage products from the BackAppX platform. <br>
• Category : this class provides a simple way to manage categories from the BackAppX platform. <br>
• Order : this class provides a simple way to manage orders from the BackAppX platform. <br>
• Payment : this class provides a simple way to manage payments from the BackAppX platform using stripe integration. <br>
• FileStorage : this class provides a simple way to manage project's files from the BackAppX platform. <br>
• Project : this class provides a simple way to link user's project to the BackAppX platform. <br>

## Installation
Add the following dependency to your pubspec.yaml:

```dart
dependencies:
  backappx: 0.1.2
```

## Requirements
The package requires the following dependencies: <br>
• Flutter 2.0.0 or higher <br>
• Dart 2.12.0 or higher <br>
• BackAppX account <br>
• BackAppX project <br>
• dart:io <br>
• dart:convert <br>
• http: ^0.13.3 <br>
• dart:async <br>
• path_provider: ^2.0.2 <br>



## Usage
To use this package, add backappx as a dependency in your pubspec.yaml file.

```dart

import 'package:backappx/project.dart';
```

## License

MIT License

Copyright (c) 2023 BackAppX

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## Additional information

For help getting started with Flutter, view our online [documentation](https://back-app-x-documentation.vercel.app/).
