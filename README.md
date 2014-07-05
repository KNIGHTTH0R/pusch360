pusch360
========

360° image rotator

# routes

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