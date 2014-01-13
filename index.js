const fs = require('fs');
const spawn = require('child_process').spawn;
const path = require('path');
const executable = path.join(__dirname, 'build', 'Release', 'capture');

function capture(options) {
  const out = options.out;

  if (out) {
    options.stdio = [null, fs.openSync(path.resolve(out), 'w'), null];
  }

  return spawn(executable, [], options);
}

module.exports = capture;
