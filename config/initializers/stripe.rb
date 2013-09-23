Rails.configuration.stripe = {
    :publishable_key => 'pk_test_uLGsctlBBuo5hd77f62lDDVc',
    :secret_key => 'sk_test_RabCz8WnVlOLo0NNGbBRtD77'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]