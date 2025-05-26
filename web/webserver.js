const http = require('http');
const fs = require('fs');
const path = require('path');
 
const server = http.createServer((req, res) => {
    const filePath = path.join(__dirname, req.url === '/' ? 'index.html' : req.url);
    const fileExt = path.extname(filePath);
    let contentType = 'text/html';
    if (fileExt === '.css') contentType = 'text/css';
    else if (fileExt === '.js') contentType = 'text/javascript';
    else if (fileExt === '.json') contentType = 'application/json';
    else if (fileExt === '.png') contentType = 'image/png';
    else if (fileExt === '.jpg') contentType = 'image/jpeg';

    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code == 'ENOENT') {
                // page not found
                fs.readFile(path.join(__dirname, '404.html'), (err, content) => {
                    res.writeHead(404, { 'Content-Type': 'text/html' });
                    res.end(content, 'utf-8');
                });
            } else {
                // some server error
                res.writeHead(500);
                res.end(`Server error: ${err.code}`);
            }
        } else {
            // success
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});

const PORT = 7980;
server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});