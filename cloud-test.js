const Rsvg = require('librsvg-prebuilt').Rsvg
const fs = require('fs');

const promise = new Promise((res, rej) => {
    const svg = new Rsvg();

    const readable = fs.createReadStream('/tmp/cloud.svg');

    svg.on('finish', () => {
        fs.writeFile('/tmp/cloud-node.png', svg.render({
            format: 'png',
            width: 256,
            height: 256
        }).data, () => res());
    });

    readable.pipe(svg);
});

promise.then(() => {
    console.log('Success!');
}).catch((e) => {
    console.log('Error:', e);
    process.exit(1);
});