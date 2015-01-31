$(document).ready(function() {
  $('#signup').click(function(e) {
    e.preventDefault();
    $("#signup-form").toggle();
    $("#login-form").hide();
  });

  $('#login').click(function(e) {
    e.preventDefault();
    $("#login-form").toggle();
    $("#signup-form").hide();
  });

  $('#login-nav').on('click','#logout',function(e) {
    e.preventDefault();
    $link = $(e.target);
    $.ajax({
      url: $link.attr('href'),
      type: 'GET',
    })
    .done(function(welcomePartial) {
      $('header').replaceWith(welcomePartial);
    });
  });

  $('.cancel-btn').click(function(e) {
    e.preventDefault();
    $(e.target).closest('form').toggle();
  });

  $('#login-form').submit(function(e) {
    e.preventDefault();
    $form = $(e.target);
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
    })
    .done(function(welcomePartial) {
      $form.toggle(400);
      $('header').replaceWith(welcomePartial);
    });
  });

  $('#signup-form').submit(function(e) {
    e.preventDefault();
    $form = $(e.target);
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
    })
    .done(function(welcomePartial) {
      $form.toggle(400);
      $('header').replaceWith(welcomePartial);
    });
  });
});
