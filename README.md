pusch360
========

360° image rotator editor and exporter

# Installation

## Software Requirements

```js
apt-get install nodejs git mongodb imagemagick zip
```
On Mac OSX use Homebrew
```js
brew install nodejs git mongodb imagemagick
```
Install node.js modules
```js
npm install -g bower grunt-cli coffee-script
```
Make sure mongod process is running, start it with

```js
mongod
```

## dowload and install

```shell
git clone https://github.com/dni/pusch360.git && cd pusch360 && npm i && bower install
```

## start the app
```shell
coffee server.coffee
```

# Routes

show if its working
* http://localhost:6166/

initialize a gallery
* http://localhost:6166/initGallery/dirName

delete/reset a gallery
* http://localhost:6166/resetGallery/dirName

view a gallery
* http://localhost:6166/gallery/dirName

download a gallery
* http://localhost:6166/downloadGallery/dirName

# how to include on your website

place to extracted zip file from downloadGallery on your webserverroot /360images/dirName
add the script

```html
<head>
    <script>
        window.Pusch360Plugins.push({selector: ".gallery1", name: "gallery1"});
    </script>
    <script type="text/javascript" src="/360images/lib.min.js"></script>
</head>
<body>
    <div class="gallery1"></div>
</body>
```