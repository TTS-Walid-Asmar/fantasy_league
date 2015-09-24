jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

add_funds =
  setupForm: ->
    $('#new_add_funds').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        add_funds.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, add_funds.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#add_funds_stripe_card_token').val(response.id)
      $('#new_add_funds')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)