const fs = require('fs');
const spawn = require('child_process').spawn;
const path = require('path');
const executable = path.join(__dirname, 'build', 'Release', 'capture');

function capture(options) {
  const out = options.out;

  // Stream the captured image file, stdout, or custom streams.
  const stdio = out ?
    [null, fs.openSync(path.resolve(options.out), 'w'), process.stderr] :
    (options.stdio || [null, process.stdout, process.stderr]);

  return spawn(executable, [], { stdio: stdio });
}

module.exports = capture;
