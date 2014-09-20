quk – the QUicK webserver
=========================

Great for prototyping client-side code!

Installation:

    npm install -g quk

Example:

    cd example
    quk

What quk gives you:

- Serves files from current directory on port 8000 (configurable using `--port` / `-p` argument).
- `index.html` support.
- No relative path exploits thanks to `resolve-path`.
- Serves compiled '*.less' files as `text/css`.
- Serves compiled '*.coffee' files as `application/javascript`.
- Provides out of the box:
  - `/angular/angular.min.js`
  - `/jquery/dist/jquery.min.js`
  - `/reset-css/reset.css`
- Provides any local bower_components sub-paths under root, e.g.:
  - `./bower_components/d3/d3.min.js` is `/d3/d3.min.js`.


TODO
----

- Serve Markdown using `marked` with user-defined layout.


License
-------

The MIT License (MIT)

Copyright (c) 2014 Felix Rabe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
