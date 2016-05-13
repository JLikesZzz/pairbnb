// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require bootstrap-sprockets


// $(function() {
//
//  $('input[name ="reservation[datefilter]"]').daterangepicker({
//      autoUpdateInput: false,
//      locale: {
//          cancelLabel: 'Clear'
//      }
//
//  });
//
//  $('input[name ="reservation[datefilter]"]').on('apply.daterangepicker', function(ev, picker) {
//      $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
//  });
//
//  $('input[name="reservation[datefilter]"]').on('cancel.daterangepicker', function(ev, picker) {
//      $(this).val('');
//  });
//
// });



$(document).on('ready page:load', function() {
  var startDate = moment()
  var endDate = moment()
  var calculatePrice = function(){
    var price = parseInt($('.book_price').attr('id'), 10);
    var date_diff = endDate.diff(startDate, 'days');
    $('.book_price').html(price * date_diff);
  }
  calculatePrice();

  $("input[name='reservation[datefilter]']").daterangepicker({
      locale: {
          format: 'DD/MM/YYYY',
                  applyLabel: 'Done',
          cancelLabel: 'Clear'
      },
      minDate: moment(),
    drops: 'up',
    autoApply: true
    });

  $("input[name='reservation[datefilter]']").on('hide.daterangepicker', function(ev, picker) {
      startDate = picker.startDate;
      endDate = picker.endDate;
      calculatePrice();
  });

  $("input[name='reservation[datefilter]']").on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
  });

  $("input[name='reservation[datefilter]']").on('cancel.daterangepicker', function(ev, picker) {
      $(this).val('');
  });

    $("select").on('change', function(){
    calculatePrice();
    });
});
