'use strict';
exports.handler = (event, context, callback) => {
    var request = event.Records[0].cf.request;
    request.uri = request.uri.replace(/\/$/, '\/index.html');
    return callback(null, request);
};