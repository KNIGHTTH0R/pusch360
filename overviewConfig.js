require.config({
  baseUrl: '/bower_components',
    paths: {
        jquery: "jquery/dist/jquery",
        backbone: "backbone-amd/backbone",
        underscore: "underscore-amd/underscore",
    },
    packages: [
      {
        name: 'cs',
        location: 'require-cs',
        main: 'cs'
       },{
        name: 'less',
        location: 'require-less',
        main: 'less'
      },{
        name: 'coffee-script',
        location: 'coffee-script',
        main: 'index'
      },{
        name: 'text',
        location: 'requirejs-text',
        main: 'text'
      }
    ]
});


require(["jquery","cs!/lib/model/Galleries", "cs!/lib/view/GalleryView"],function($, Galleries, GalleryView){
    Galleries.fetch({
        success:function(){
            Galleries.forEach(function(gallery){
              view = new GalleryView({model:gallery});
              $("body").append(view.render());
            })
        }
    })
});

//require(['cs!/lib/App.coffee']);

