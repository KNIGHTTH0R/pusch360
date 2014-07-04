require.config({
  baseUrl: 'bower_components',
    paths: {
        jquery: "jquery",
        backbone: "backbone",
        cs: "coffee-script/index"
    },
    packages: [
      {
        name: 'less',
        location: 'require-less',
        main: 'less'
      },{
        name: 'coffee-script',
        location: 'require-cs',
        main: 'coffee-script'
      },{
        name: 'text',
        location: 'requirejs-text',
        main: 'text'
      }
    ]
});

require(['cs!coffee/main.coffee']);
