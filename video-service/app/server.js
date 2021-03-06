

const winston = require('winston');
const express = require('express');
const morgan = require('morgan');
const multer = require('multer');
const config = require('config');

const contextPath = '/api/v2';
const servletPath = '/videoservice';

/* Configuration */
const app = express();
const port = config.get('server.port');
const uploadDir = config.get('uploadDir');
const upload = multer({ dest: uploadDir });

app.use(morgan('dev'));

/* Load Controllers */
const videoController = require('./videos/video.controller');

/* Video Routes */
const videoRouter = express.Router();
videoRouter.post('/upload', upload.single('video'), videoController.uploadVideo);
app.use(contextPath + servletPath + '/videos', videoRouter);

app.listen(port, () => {
    winston.info('server started on port', port);
});
