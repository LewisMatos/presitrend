var my_data; 
setInterval(function(){
  $.get('/getpopcandidate').done(function(data){ 
    var hash = {};
    for (var i in data) {
      if (data[i].cand_pop < 1) {
       hash[i] = {
       'fillKey':0, 
       'name':"empty", 
       'pop':data[i].cand_pop
      }; 
      } else {
        hash[i] = {
         'fillKey':data[i].cand_id, 
         'name':data[i].candidate, 
         'pop':data[i].cand_pop
        }; 
      }
        
    }
    my_data = hash;
    $("#graph").empty();
    drawMap();

  });
},1000);



 function drawMap (argument) {
    var election = new Datamap({
  scope: 'usa',
  element: document.getElementById('graph'),
  geographyConfig: {
    highlightBorderColor: '#bada55',
   popupTemplate: function(geography, data) {
      return '<div class="hoverinfo">' + geography.properties.name +' candidate Name: '+ data.name +'Tweets:' +  data.pop + ' '
    },
    highlightBorderWidth: 3
  },

  fills: {
	'0': '#eee',	
  '1': '#2E0DC0',
  '2': '#A80000',
  '3': '#5C8AA8',
  '4': '#328ae8',
  '5': '#0174FF',
  '6': '#9F0000',
	'7': '#7F0000',
	'8': '#FF372D',
  '9': '#F80000',
 '10': '#8A1A00',
 '11': '#6A0000',
 '12': '#540000',
 '13': '#CF1721',
 '14': '#D40000',
 '15': '#B41C1A',
 '16': '#E32736',
 '17': '#E72122',
 '18': '#480000',
 '19': '#9D0000',
 '20': '#DD639C',	
  defaultFill: '#eee'},
data: my_data
});

election.labels();
 }
