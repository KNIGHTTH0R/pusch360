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

require(['jquery', 'cs!UserApp'],function($, Gallery){
  window.Pusch360Gallery = Gallery;
  var event = new CustomEvent("pusch360");
  $(function(){
    document.dispatchEvent(event);
  });
});
