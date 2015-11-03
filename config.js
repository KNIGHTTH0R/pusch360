require.config({
    baseUrl: '/lib',
    packages: [
      {
        name: 'cs',
        location: '.',
        main: 'cs'
       },{
       	name: 'coffee-script',
        location: '.',
        main: 'coffee-script'
      },{
        name: 'text',
        location: '.',
        main: 'text'
      }
    ]
});

require(["jquery", 'cs!App'], function($, App){
  window.Pusch360Gallery = App;
  var event = new CustomEvent("pusch360");
  $(function(){
    document.dispatchEvent(event);
  });
});
