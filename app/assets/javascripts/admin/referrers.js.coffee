class @Referrers
  constructor: (scope) ->
    @table = scope
    @bind()

  bind: ->
    @table.find('a').on 'click', @toggleReferrals

  toggleReferrals: (ev) =>
    tr = $(ev.target).parent().parent()
    id = tr.data('referrerId')
    referrals = tr.closest('table').find("tr.referrals[data-referrer-id='#{id}']")
    @toggleLines(referrals)

  toggleLines: (referrals) ->
    if referrals.hasClass('hidden')
      referrals.removeClass('hidden')
    else
      referrals.addClass('hidden')

$ ->
  scope = $('table.referrers-table')
  new Referrers(scope)
