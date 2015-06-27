$ ->
  credentialsToggler = $('.collapsable-credentials .toggler')
  vpnCredentials = $('.collapsable-credentials .vpn-credential')

  credentialsToggler.click (e) ->
    e.preventDefault()
    vpnCredentials.toggle()

  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "mm-dd-yy"
      dateFormat: "mm-dd-yy"
      altField: $(this).next()
