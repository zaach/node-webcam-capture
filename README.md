# webcam-capture

Capture frames from you webcam.

This was part of a little weekend hack, so it only works for OS X. Please send PRs for your platform or webcam setup.

Cheers,
[@zii](https://twitter.com/zii)

## Example

    var capture = require('webcam-capture');
    var spawn = capture({ stdio: [null, process.stdin, null] });
    // shortcut to write to a file
    // var spawn = capture({ out: 'me.jpg' });

## License

MIT
