var exec = require('cordova/exec');

var PLUGIN_NAME = 'MyEventSource';

exports.initialize = function (url, success, error) {
  exec(success, error, PLUGIN_NAME, "initialize", [url]);
};

exports.Open = function (url, success, error) {
  exec(success, error, PLUGIN_NAME, "open", [url]);
};

exports.onMessage = function (success, error) {
  exec(success, error, PLUGIN_NAME, "onMessage", []);
};
