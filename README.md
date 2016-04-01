# growl-express

[![NPM](https://nodei.co/npm/growl-express.svg?style=flat)](https://npmjs.org/package/growl-express)

## Installing

```shell-script
$ npm install --global growl-express
```

## Startup

Optional environment variables are PORT to define the http listening port
and DISABLE_LOGGING set as "true" to disable logging.

```shell-script
$ growl-express
Server listening on :::23054
```

## Usage

The growl-express server exposes three POST methods: `/register`, `/notify`, and `/setHost`.

### [POST] /register

Registers a new application with Growl. Registration is completely optional since it will be performed automatically for you with sensible defaults. Useful if you want your application, with its own icon and types of notifications, to show up in Growl's prefence panel.

#### Parameters

- `appname` the name of the application (default is 'growl-express')
- `appicon` url, file path, or Buffer instance for an application icon image.
- `notifications` a list of defined notification types with the following properties:
  - `.label` name used to identify the type of notification being used (required.)
  - `.dispname` name users will see in Growl's preference panel (defaults to `.label`.)
  - `.enabled` whether or not notifications of this type are enabled (defaults to true.)
  - `.icon` url or file path for the notification's icon.

#### Example

```shell-script
curl --header "Content-Type: application/json" --request POST --data '{
    "appname": "growl-express-example-app",
    "notifications": [
      { "label": "default", "icon": "http://imgur.com/amjVCj6.jpg" },
      { "label": "success", "icon": "http://imgur.com/WjZjXjP.jpg" },
      { "label": "error",   "icon": "http://imgur.com/rvtftG9.jpg" }
  ] }' http://localhost:23054/register
```

### [POST] /notify

Sends a Growl notification. If an application wasn't registered beforehand with `growly.register()`, a default application will automatically be registered beforesending the notification.

#### Parameters

- `text` the body of the notification.
- `options` an object with the following properties:
  - `.title` title of the notification.
  - `.icon` url or file path for the notification's icon.
  - `.sticky` whether or not to sticky the notification (defaults to false.)
  - `.label` type of notification to use (defaults to the first registered notification type.)
  - `.priority` the priority of the notification from lowest (-2) to highest (2).
  - `.coalescingId` replace/update the matching previous notification. May be ignored.

#### Examples

```shell-script
curl --header "Content-Type: application/json" --request POST --data '{
    "text": "such notify!",
    "options": { "title": "wow" }
  }' http://localhost:23054/notify

curl --header "Content-Type: application/json" --request POST --data '{
    "text": "systems ok!",
    "options": { "label": "success" }
  }' http://localhost:23054/notify

curl --header "Content-Type: application/json" --request POST --data '{
    "text": "everything is broken!",
    "options": {
      "title":"oh no! 😢",
      "label":"error",
      "sticky":true }
  }' http://localhost:23054/notify
```

### [POST] /setHost

Set the host and port that Growl (GNTP) requests will be sent to. Using this method is optional since GNTP defaults to using host 'localhost' and port 23053.

#### Parameters

- `host` GNTP host
- `port` GNTP port

#### Example

```shell-script
curl --header "Content-Type: application/json" --request POST --data '{
    "host": "some-other-host",
    "port": 1337
  }' http://localhost:23054/setHost
```

## See Also
<https://github.com/theabraham/growly>

## License

The MIT License (MIT)

Copyright 2016 Erik Wilson

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
