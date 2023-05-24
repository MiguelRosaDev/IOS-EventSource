var exec = require('cordova/exec');

var PLUGIN_NAME = 'EventSource';

exports.initialize = function (url, success, error) {
  exec(success, error, PLUGIN_NAME, "initWithURL", [url]);
};

exports.Open = function (url, success, error) {
  exec(success, error, PLUGIN_NAME, "onOpen", [url]);
};

exports.onMessage = function (success, error) {
  exec(success, error, PLUGIN_NAME, "onMessage", []);
};
