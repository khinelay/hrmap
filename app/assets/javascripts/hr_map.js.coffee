$ ->
  $(document).on "click", "#quick-actions-link", (e) ->
    e.preventDefault()
    if $("#quick-actions-link").hasClass("active") == true
      $("#quick-actions-link").removeClass("active")
      $(".wrapper").removeClass("inactive")
    else
      $("#quick-actions-link").addClass("active")
      $(".wrapper").addClass("inactive")
