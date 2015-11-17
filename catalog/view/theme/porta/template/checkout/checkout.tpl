<?php echo $header; ?>
<div class="container-fluid main">
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">
                <div class="row c-b mt-20">
                    <div class="col-xs-2">
                        <?php echo $column_left; ?>
                    </div>
                    <main class="col-xs-8">
                        <div class="breadcrumb">
                            <?php foreach ($breadcrumbs as $i=>$breadcrumb) { ?>
                            <?php echo $breadcrumb['separator']; ?>
                            <?php if($i+1 < count($breadcrumbs)){ ?>
                            <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                            <?php } else { ?>
                            <?php echo $breadcrumb['text']; ?>
                            <?php } ?>
                            <?php } ?>
                        </div>
                        <h1><?php echo $heading_title; ?> </h1>
                        <div class="content_block">
                            <div class="panel-group" id="accordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_payment_address; ?></h4>
                                    </div>
                                    <div class="panel-collapse" id="collapse-payment-address">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_confirm; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-checkout-confirm">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </main>
                    <div class="col-xs-2">
                        <?php echo $column_right; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<?php echo $footer; ?>



<script type="text/javascript"><!--
    // Checkout
    $(document).ready(function() {
        $.ajax({
            url: 'index.php?route=checkout/guest',
            dataType: 'html',
            beforeSend: function() {
                $('#button-account').button('loading');
            },
            complete: function() {
                $('#button-account').button('reset');
            },
            success: function(html) {
                $('.alert, .text-danger').remove();

                $('#collapse-payment-address .panel-body').html(html);

                if ($('input[name=\'account\']:checked').val() == 'register') {
                    $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
                } else {
                    $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
                }

                $('a[href=\'#collapse-payment-address\']').trigger('click');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });



        $("#button-guest").click(function(){
            return validateint($(this));
        });
        function validateint(form){
            var f = true;
            var inputs = form.find('.int-only');
            var val_int;
            inputs.each(function(){
                val_int = $(this).val();
                var re = /^\+?\d[\d\(\)\ \-\+]{4,15}\d$/;
                var myPhone = $('.int-only').val();
                var valid = re.test(myPhone);
                if(!valid && val_int.length > 0){
                    $(this).addClass('er-in') ;
                    $(this).next('span').html("Некорректный номер");
                    f = false;
                }

                $(this).on("keyup, keydown", function(){
                    $(this).removeClass('er-in') ;
                    $(this).next('span').html("");
                })

            });

            if(f){
                return true;
            }
            else{
                return false;
            }
        }
    });

    // Guest
    $(document).delegate('#button-guest', 'click', function() {
        $.ajax({
            url: 'index.php?route=checkout/guest/save',
            type: 'post',
            data: $('#collapse-payment-address input[type=\'text\'],  #collapse-payment-address input[type=\'checkbox\']:checked,  #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-guest').button('loading');
            },
            complete: function() {
                $('#button-guest').button('reset');
            },
            success: function(json) {
                $('.alert, .text-danger').remove();
                $('.form-group').removeClass('has-error');
                if (json['redirect']) {
                    //location = json['redirect'];
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    }

                    for (i in json['error']) {
                        var element = $('#input-payment-' + i.replace('_', '-'));

                        if ($(element).parent().hasClass('input-group')) {
                            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                        } else {
                            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                        }
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                } else {
                    $.ajax({
                        url: 'index.php?route=checkout/confirm',
                        dataType: 'html',
                        success: function(html) {
                            $('#collapse-checkout-confirm .panel-body').html(html);

                            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');

                            $('a[href=\'#collapse-checkout-confirm\']').trigger('click');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    var input = $("#input-payment-telephone");
    input.on('keyup', function(){
        var val = $(this).val();
        reg = /[^\+\d\-\{1}]/;
        if(reg.test(val))
        {
            $(this).val(val.slice(0,-1));

        }
    });





    //--></script>
