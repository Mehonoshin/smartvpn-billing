$('#ribbon').append('<div class="demo"><span id="demo-setting"><i class="fa fa-cog txt-color-blueDark"></i></span> <form class="smart-form"><section><label class="checkbox"><input type="checkbox" name="subscription" id="smart-fixed-nav"><i></i>Fixed Header</label><label class="checkbox"><input type="checkbox" name="terms" id="smart-fixed-ribbon"><i></i>Fixed ribbon</label><label class="checkbox"><input type="checkbox" name="terms" id="smart-fixed-navigation"><i></i>Fixed Navigation</label><label class="checkbox"><input type="checkbox" name="terms" id="smart-fixed-container"><i></i>Inside <b>.container</b></label></section><section><a href="javascrtipt:void(0)" class="btn btn-primary"><i class="fa fa-refresh"></i> Widget Reset</a></section></form> </div>')


$('#demo-setting').click(function(){
  console.log('setting');
  $('#ribbon .demo').toggleClass('activate');
})





$('input[type="checkbox"]#smart-fixed-nav').click(function() { 
    if ($(this).is(':checked')) {
        //checked
    $.root_.addClass("fixed-header");
    } else {
        //unchecked
         $('input[type="checkbox"]#smart-fixed-ribbon').prop('checked', false);
         $('input[type="checkbox"]#smart-fixed-navigation').prop('checked', false);
         
         $.root_.removeClass("fixed-header");
         $.root_.removeClass("fixed-navigation");
         $.root_.removeClass("fixed-ribbon"); 
         
    }
});

$('input[type="checkbox"]#smart-fixed-ribbon').click(function() { 
    if ($(this).is(':checked')) {
        //checked
        $('input[type="checkbox"]#smart-fixed-nav').prop('checked', true);
        
        $.root_.addClass("fixed-header");
        $.root_.addClass("fixed-ribbon");
        
        $('input[type="checkbox"]#smart-fixed-container').prop('checked', false); 
        $.root_.removeClass("container");
    
    } else {
      //unchecked
         $('input[type="checkbox"]#smart-fixed-navigation').prop('checked', false);
         $.root_.removeClass("fixed-ribbon");
         $.root_.removeClass("fixed-navigation");
    }
});

$('input[type="checkbox"]#smart-fixed-navigation').click(function() { 
    if ($(this).is(':checked')) {
      
        //checked
        $('input[type="checkbox"]#smart-fixed-nav').prop('checked', true);
        $('input[type="checkbox"]#smart-fixed-ribbon').prop('checked', true);
        
        //apply
        $.root_.addClass("fixed-header");
        $.root_.addClass("fixed-ribbon"); 
        $.root_.addClass("fixed-navigation");
        
        $('input[type="checkbox"]#smart-fixed-container').prop('checked', false); 
        $.root_.removeClass("container");
    
    } else {
      //unchecked
         $.root_.removeClass("fixed-navigation");
    }
});

$('input[type="checkbox"]#smart-fixed-container').click(function() { 
    if ($(this).is(':checked')) {
      //checked
     $.root_.addClass("container");
     
     $('input[type="checkbox"]#smart-fixed-ribbon').prop('checked', false); 
     $.root_.removeClass("fixed-ribbon");
     
     $('input[type="checkbox"]#smart-fixed-navigation').prop('checked', false); 
     $.root_.removeClass("fixed-navigation");
    
    } else {
      //unchecked
         $.root_.removeClass("container");
    }
});
