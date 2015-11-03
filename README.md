pusch360
========

360° image rotator editor and exporter

# Installation

## Software Requirements

```js
apt-get install nodejs git mongodb graphicsmagick zip npm
```
On Mac OSX use Homebrew
```js
brew install nodejs git mongodb graphicsmagick
```
Install node.js modules
```js
npm install -g bower grunt-cli coffee-script
```
Make sure mongod process is running, start it with

```js
mongod
```

## dowload, install and build

```shell
git clone https://github.com/dni/pusch360.git && cd pusch360 && npm i && bower install && grunt build
```


## start the app
```shell
coffee server.coffee
```

# Routes

preview your gallieres (overview)
* http://localhost:6166/

initialize a gallery
* http://localhost:6166/init/dirName

delete/reset a gallery
* http://localhost:6166/reset/dirName

view a gallery
* http://localhost:6166/show/dirName

download a gallery
* http://localhost:6166/download/dirName

# how to include on your website

place to extracted zip file from downloadGallery on your webserverroot /360images/dirName
place this into your html

```html
<head>
    <link rel="stylesheet" type="text/css" href="/360images/style.css" media="all">
</head>
<body>
    <div class="gallery1"></div>
    <script type="text/javascript" src="/360images/pusch360.min.js"></script>
    <script>
      // init on startup
      document.addEventListener("pusch360", function(){
        var gallery1 = new Pusch360Gallery({selector: "gallery1", dir: "8000_SB_Background"});
      });
      // or init dynamically
      $('#myModal').on('shown.bs.modal', function (e) {
        new Pusch360Gallery({selector: "someHTMLid", dir: "8000_SB_Background"});
      });
    </script>
</body>
```
