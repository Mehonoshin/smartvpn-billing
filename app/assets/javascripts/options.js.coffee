class @Options
  constructor: (scope) ->
    @option = $(scope)
    @bind()

  bind: ->
    @option.find('select').on 'change', @update

  update: (ev) ->
    $(ev.target).closest('form').submit()

$ ->
  $("tr.option").each ->
    new Options(this)


