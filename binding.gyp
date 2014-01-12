{
  "targets": [
    {
      "target_name": "capture",
      "type": "executable",
      "conditions": [
        [
          "OS=='mac'",
            {
              "sources": [ "src/qt-capture.m" ],
              "link_settings": {
                "libraries": [
                  "-framework",
                  "Foundation",
                  "$(SDKROOT)/System/Library/Frameworks/Cocoa.framework",
                  "$(SDKROOT)/System/Library/Frameworks/QTKit.framework",
                ]
              }
            }
        ]
      ]
    }
  ]
}
