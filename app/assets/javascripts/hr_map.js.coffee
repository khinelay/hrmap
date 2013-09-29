$ ->
  $(document).on "click", "#quick-actions-link", (e) ->
    e.preventDefault()
    if $("#quick-actions-link").hasClass("active") == true
      $("#quick-actions-link").removeClass("active")
      $(".wrapper").animate
        marginLeft: "0"
    else
      $("#quick-actions-link").addClass("active")
      $(".wrapper").animate
        marginLeft: "400px"
