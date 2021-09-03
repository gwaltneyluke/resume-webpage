'use strict';

const puppeteer = require('puppeteer');
const url = 'http://www.gwaltney-resume.com.s3-website-us-east-1.amazonaws.com/';
const resumePath = './gwaltneyresume.pdf';

(async () => {
    let browser = await puppeteer.launch();
    let page = await browser.newPage();
    await page.goto(url, { waitUntil: 'networkidle2' });
    await page.pdf({ path: resumePath, format: 'letter' });
    await browser.close();
})();