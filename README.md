# SmartCleanPush

[![Version](https://img.shields.io/badge/version-1.4.0-blue.svg)](https://github.com/yourusername/SmartCleanPush)
[![SketchUp](https://img.shields.io/badge/SketchUp-Plugin-red.svg)](https://www.sketchup.com/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A powerful SketchUp plugin designed to simplify geometry cleanup and push/pull operations. SmartCleanPush is especially useful for optimizing models with complex structures by removing unnecessary inner faces and applying uniform thickness to multiple faces simultaneously.

## 🚀 Features

### Core Functionality
- **Remove Inner Faces and Push/Pull**: Cleans inner geometry and applies thickness to selected faces in one operation
- **Remove Inner Faces Only**: Removes unnecessary inner geometry without additional operations
- **Multiple Push/Pull**: Applies uniform push/pull operations to multiple faces at once

### User Interface
- **Dedicated Toolbar**: Easy access to all features with custom icons
- **Extensions Menu Integration**: All commands accessible via Extensions > SmartCleanPush
- **Interactive Dialogs**: User-friendly input prompts for distance values
- **Help System**: Built-in HTML help documentation
- **About Dialog**: Plugin information with developer details

## 📋 Requirements

- **SketchUp**: Version 2017 or later
- **Ruby**: Built-in Ruby interpreter (included with SketchUp)
- **Operating System**: Windows, macOS, or Linux

## 🛠️ Installation

### Method 1: Manual Installation
1. Download the latest release from the [Releases](https://github.com/yourusername/SmartCleanPush/releases) page
2. Extract the plugin files to your SketchUp plugins directory:
   - **Windows**: `C:\Users\[username]\AppData\Roaming\SketchUp\SketchUp [version]\SketchUp\Plugins\`
   - **macOS**: `~/Library/Application Support/SketchUp [version]/SketchUp/Plugins/`
3. Restart SketchUp
4. The plugin will appear in the Extensions menu

### Method 2: Extension Warehouse (Future)
*Coming soon - the plugin will be available through SketchUp's Extension Warehouse*

## 📖 Usage

### Getting Started
1. **Load the Plugin**: After installation, the plugin will be available in the Extensions menu
2. **Select Geometry**: Choose the faces or geometry you want to process
3. **Choose Operation**: Use either the toolbar or menu to select your desired operation
4. **Enter Parameters**: When prompted, enter the push/pull distance in centimeters

### Available Commands

#### 1. Remove Inner Faces and Push/Pull
- **Purpose**: Cleans inner geometry and applies thickness
- **Usage**: Select faces → Click toolbar button or use menu
- **Input**: Distance in centimeters (e.g., "2.5" for 2.5cm)
- **Result**: Removes inner faces and applies push/pull to remaining faces

#### 2. Remove Inner Faces Only
- **Purpose**: Removes unnecessary inner geometry
- **Usage**: Select faces → Click toolbar button or use menu
- **Input**: None required
- **Result**: Removes inner faces without additional operations

#### 3. Multiple Push/Pull
- **Purpose**: Applies uniform push/pull to multiple faces
- **Usage**: Select faces → Click toolbar button or use menu
- **Input**: Distance in centimeters
- **Result**: Applies push/pull to all selected faces with the same distance

### Toolbar Interface
The plugin provides a dedicated toolbar with three main buttons:
- 🧹 **Remove Inner Faces and Push/Pull** (16x16 and 24x24 icons)
- 🔧 **Multiple Push/Pull** (16x16 and 24x24 icons)
- 🎯 **Remove Inner Faces Only** (16x16 and 24x24 icons)

### Menu Access
All commands are also available through:
- **Extensions** → **SmartCleanPush** → [Command Name]
- **Support**: Opens the help documentation
- **About**: Shows plugin information and developer details

## 🎯 Use Cases

### Architecture
- Clean up imported CAD files with redundant geometry
- Apply uniform wall thickness to building models
- Optimize complex architectural details

### Product Design
- Prepare models for 3D printing by removing internal geometry
- Apply consistent material thickness to product components
- Clean up imported mesh files

### General Modeling
- Optimize models for better performance
- Prepare geometry for rendering
- Clean up complex boolean operations

## 🔧 Technical Details

### Plugin Structure
```
SmartCleanPush/
├── SmartCleanPush.rb          # Main extension loader
├── SmartCleanPush/
│   ├── main.rb               # Core functionality
│   ├── help.html             # Help documentation
│   ├── my_photo.jpg          # Developer photo
│   └── icons/                # Plugin icons
│       ├── scp_main_icon_16.png
│       ├── scp_main_icon_24.png
│       ├── scp_inner_face_16.png
│       ├── scp_inner_face_24.png
│       ├── scp_inner_push_16.png
│       ├── scp_inner_push_24.png
│       ├── scp_multi_push_16.png
│       └── scp_multi_push_24.png
└── README.md                 # This file
```

### Key Methods
- `remove_inner_faces_and_pushpull()`: Main cleanup and push/pull operation
- `remove_inner_only()`: Inner face removal only
- `multiple_push_pull()`: Multiple face push/pull operation
- `show_about_dialog()`: About dialog with developer information
- `show_help()`: Help documentation viewer

### Inner Face Detection Logic
The plugin identifies inner faces by checking if all edges of a face are shared by multiple faces:
```ruby
if face.edges.all? { |edge| edge.faces.size > 1 }
  face.erase!
end
```

## 🐛 Troubleshooting

### Common Issues

#### Plugin Not Loading
- **Solution**: Ensure the plugin files are in the correct directory
- **Check**: Verify SketchUp version compatibility (2017+)
- **Restart**: Restart SketchUp after installation

#### Commands Not Working
- **Selection Required**: Make sure you have geometry selected before running commands
- **Face Selection**: Commands work best with face selections
- **Undo**: Use Ctrl+Z (Windows) or Cmd+Z (Mac) to undo operations

#### Performance Issues
- **Large Models**: For very large models, consider processing in smaller sections
- **Complex Geometry**: Some complex geometry may take longer to process

### Getting Help
1. **Built-in Help**: Use Extensions > SmartCleanPush > Support
2. **About Dialog**: Check Extensions > SmartCleanPush > About for version info
3. **Contact Developer**: Email cdeshapriya91@gmail.com

## 🔄 Version History

### Version 1.4.0 (Current)
- Enhanced user interface with dedicated toolbar
- Improved help system with HTML documentation
- Added about dialog with developer information
- Better error handling and user feedback
- Optimized inner face detection algorithm

### Previous Versions
- **1.3.0**: Added multiple push/pull functionality
- **1.2.0**: Improved inner face detection
- **1.1.0**: Added menu integration
- **1.0.0**: Initial release with basic functionality

## 🤝 Contributing

We welcome contributions to improve SmartCleanPush! Here's how you can help:

### Development Setup
1. Fork the repository
2. Clone your fork locally
3. Make your changes
4. Test thoroughly in SketchUp
5. Submit a pull request

### Areas for Contribution
- **Bug Fixes**: Report and fix issues
- **Feature Requests**: Suggest new functionality
- **Documentation**: Improve help files and documentation
- **Localization**: Add support for other languages
- **Testing**: Test on different SketchUp versions

### Code Style
- Follow Ruby conventions
- Add comments for complex logic
- Test all changes before submitting
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**R.K.D Chinthaka Deshapriya**
- 📧 Email: [cdeshapriya91@gmail.com](mailto:cdeshapriya91@gmail.com)
- 🌐 Facebook: [https://www.facebook.com/chinthakadesh](https://www.facebook.com/chinthakadesh)
- 📍 Location: Sri Lanka

## 🙏 Acknowledgments

- SketchUp team for providing the excellent platform
- Ruby community for the programming language
- Beta testers and users who provided feedback
- Open source community for inspiration and tools

## 📞 Support

For support, feature requests, or bug reports:
- **Email**: cdeshapriya91@gmail.com
- **Facebook**: [https://www.facebook.com/chinthakadesh](https://www.facebook.com/chinthakadesh)
- **Issues**: Use the GitHub Issues page for bug reports

## 🔮 Future Plans

- **Extension Warehouse**: Submit to SketchUp's official extension store
- **Advanced Features**: 
  - Batch processing for multiple models
  - Custom thickness profiles
  - Advanced geometry analysis
- **Performance**: Optimize for larger models
- **Localization**: Support for multiple languages
- **Integration**: Better integration with other SketchUp plugins

---

**Made with ❤️ for the SketchUp community**

*SmartCleanPush - Simplifying geometry cleanup and push/pull operations in SketchUp*