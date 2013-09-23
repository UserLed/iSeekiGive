$(document).ready(function(){
    $('.billing-settings input, .billing-settings select').attr('disabled', false);
    $('.stripe-token').val('');

    $('.billing-settings').on('submit', function(e){
        var form = this;
        var submit = $(this).find('input[type=submit]');
        var submit_prev_val = submit.val();

        submit.val('Please wait...').attr('disabled', true).end();

        Stripe.card.createToken({
            name: $('.card-holder-name').val(),
            number: $('.card-number').val(),
            cvc: $('.card-cvc').val(),
            exp_month: $('#_expiry_date_2i').val(),
            exp_year: $('#_expiry_date_1i').val()
        }, stripeResponseHandler);

        function stripeResponseHandler(status, response) {
            if (status === 200) {
                $(".stripe-token").val(response.id);
                form.submit();
            } else {
                $(".alert-block").html("<h4>Error!</h4>" + response.error.message).delay(500).fadeIn(500);
                $(".alert-block").delay(4000).fadeOut(1500);
                submit.val(submit_prev_val).attr('disabled', false).end();
            }
        }
        return false;
    });
});