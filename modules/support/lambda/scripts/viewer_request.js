'use strict';
exports.handler = (event, context, callback) => {
    request.uri = event.Records[0].cf.request.uri.replace(/\/$/, '\/index.html');
    return callback(null, request);
};