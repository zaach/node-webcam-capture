const fs = require('fs');
const spawn = require('child_process').spawn;
const path = require('path');
const executable = path.join(__dirname, 'build', 'Release', 'capture');

function capture(options) {
  const camera = spawn(executable, [], options);

  if (options.out) {
    var image = fs.createWriteStream(path.resolve(options.out), {encoding: 'binary'});
    camera.stdout.pipe(image);
  }

  return camera;
}

module.exports = capture;
